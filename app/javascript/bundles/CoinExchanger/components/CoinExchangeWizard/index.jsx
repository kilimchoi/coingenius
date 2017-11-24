import React, { Component } from 'react';
import { Button, Col, Container } from 'reactstrap';
import { Wizard, Step, Steps, Navigation } from 'react-albus';
import { decamelizeKeys } from 'humps';
import promisePoller from 'promise-poller';
import { createConversion, fetchConversion } from '_sources/convertions';
import StepOne from '_bundles/CoinExchanger/components/StepOne';
import StepTwo from '_bundles/CoinExchanger/components/StepTwo';
import StepThree from '_bundles/CoinExchanger/components/StepThree';

const defaultCoin = {
  id: 0,
  label: '',
  symbol: '',
  value: '',
};
const passThrough = value => value;
const coerceToFloat = value => parseFloat(value);
const coercions = {
  sendAmount: coerceToFloat,
  rate: coerceToFloat,
};
const coerceProxy = new Proxy(coercions, {
  get: (target, name) => target[name] || passThrough,
});
const TERMINAL_STATUSES = ['complete', 'failed'];

class CoinExchanger extends Component {
  constructor(props) {
    super(props);

    this.state = {
      rate: 1.0,
      sendAmount: 0.0,
      sendingCoin: { ...defaultCoin },
      receiveCoin: { ...defaultCoin },
      withdrawalAddress: '',
      returnAddress: '',
    };
  }

  handleValueChange = (name, value) => {
    this.setState({
      [name]: coerceProxy[name](value),
    });
  };

  handleExchange = (next) => {
    next();
    this.createConversionAndSetId();
    this.pollTransactionStatus();
  };

  isStepOneNextDisabled = () => {
    const { sendAmount, sendingCoin, receiveCoin } = this.state;

    return !(sendAmount && sendingCoin && receiveCoin && sendingCoin.id && receiveCoin.id);
  };

  isStepTwoNextDisabled = () => {
    const { withdrawalAddress, returnAddress } = this.state;

    return !(withdrawalAddress && returnAddress);
  };

  createConversionAndSetId = () => {
    const { withdrawalAddress, returnAddress } = this.state;
    const params = decamelizeKeys({
      returnAddress: withdrawalAddress,
      returnAddress,
    });
    createConversion(params).then(({ serializedBody: { id } }) => {
      this.setState({ conversionId: id });
    });
  };

  pollTransactionStatus = () => {
    const id = this.state.conversionId;
    const taskFn = fetchConversion({ id }).then(({ serializedBody: { status } }) => {
      this.setState({ status });

      return status;
    });

    promisePoller({
      taskFn,
      shouldContinue: (error, status) => error || TERMINAL_STATUSES.includes(status),
      interval: 500,
      retries: 3,
    });
  };

  render() {
    const { sendAmount, rate, status } = this.state;
    const receiveAmount = sendAmount * rate;
    const params = {
      onValueChange: this.handleValueChange,
      receiveAmount,
      ...this.state,
    };

    return (
      <Container fluid>
        <Col md={9}>
          <h2 className="mt-3 mb-3">Coin Exchange</h2>
          <Wizard>
            <Steps>
              <Step path="stepOne">
                <StepOne {...params} />
                <Navigation
                  render={({ next }) => (
                    <Button
                      disabled={this.isStepOneNextDisabled()}
                      className="pull-right"
                      size="lg"
                      onClick={next}
                    >
                      Next
                    </Button>
                  )}
                />
              </Step>
              <Step path="stepTwo">
                <StepTwo {...params} />
                <Navigation
                  render={({ next, previous }) => (
                    <div>
                      <div className="pull-right">
                        <Button size="lg" onClick={previous}>
                          Previous
                        </Button>{' '}
                        <Button
                          size="lg"
                          disabled={this.isStepTwoNextDisabled()}
                          onClick={() => this.handleExchange(next)}
                        >
                          Next
                        </Button>
                      </div>
                    </div>
                  )}
                />
              </Step>
              <Step path="stepThree">
                <StepThree {...params} status={status} />
              </Step>
            </Steps>
          </Wizard>
        </Col>
      </Container>
    );
  }
}

export default CoinExchanger;
