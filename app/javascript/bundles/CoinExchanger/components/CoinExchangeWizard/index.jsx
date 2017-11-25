import React, { Component } from 'react';
import { Button, Col, Row } from 'reactstrap';
import { Wizard, Step, Steps, Navigation } from 'react-albus';
import { decamelizeKeys } from 'humps';
import promisePoller from 'promise-poller';
import { createConversion, fetchConversion } from '_sources/convertions';
import StepOne from '_bundles/CoinExchanger/components/StepOne';
import StepTwo from '_bundles/CoinExchanger/components/StepTwo';
import StepThree from '_bundles/CoinExchanger/components/StepThree';

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
      sendAmount: 0.01,
      sendingCoin: {
        id: 1,
        label: 'Bitcoin (BTC)',
        symbol: 'BTC',
        value: 'Bitcoin (BTC)',
      },
      receiveCoin: {
        id: 2,
        label: 'Ethereum (ETH)',
        symbol: 'ETH',
        value: 'Ethereum (ETH)',
      },
      withdrawalAddress: '',
      returnAddress: '',
      status: 'no_deposits',
    };
  }

  componentDidUpdate(prevProps, prevState) {
    this.switchCoins(prevState);
  }

  handleValueChange = (name, value) => {
    this.setState({
      [name]: coerceProxy[name](value),
    });
  };

  handleExchange = (next) => {
    next();
    this.createConversionAndSetId().then(this.pollConversionStatus());
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
    const {
      sendingCoin: { id: sendingCoinId },
      receiveCoin: { id: receiveCoinId },
      returnAddress,
      withdrawalAddress,
    } = this.state;
    const params = decamelizeKeys({
      sendingCoinId,
      receiveCoinId,
      returnAddress,
      withdrawalAddress,
    });

    return createConversion(params).then(({ serializedBody: { id } }) => {
      this.setState({ conversionId: id });
    });
  };

  pollConversionStatus = () => {
    const { conversionId } = this.state;

    if (conversionId) {
      const taskFn = fetchConversion(conversionId).then(({ serializedBody: { status } }) => {
        this.setState({ status });

        return status;
      });

      promisePoller({
        interval: 500,
        retries: 3,
        shouldContinue: (error, status) => error || TERMINAL_STATUSES.includes(status),
        taskFn,
      });
    }
  };

  switchCoins(prevState) {
    const { sendingCoin, receiveCoin } = this.state;
    const areCoinsEqual = sendingCoin && receiveCoin && sendingCoin.id === receiveCoin.id;

    if (areCoinsEqual) {
      this.setState({ sendingCoin: prevState.receiveCoin });
    }
  }

  render() {
    const { sendAmount, rate, status } = this.state;
    const receiveAmount = sendAmount * rate;
    const params = {
      onValueChange: this.handleValueChange,
      receiveAmount,
      ...this.state,
    };

    return (
      <Row className="justify-content-center">
        <Col md={9}>
          <h2 className="mt-3 mb-3">Coin Exchange</h2>
          <Wizard>
            <Steps>
              <Step path="stepOne">
                <StepOne {...params} />
                <Navigation
                  render={({ next }) => (
                    <div>
                      <Button
                        className="w-100"
                        disabled={this.isStepOneNextDisabled()}
                        size="lg"
                        onClick={next}
                      >
                        Next
                      </Button>
                    </div>
                  )}
                />
              </Step>
              <Step path="stepTwo">
                <StepTwo {...params} />
                <Navigation
                  render={({ next, previous }) => (
                    <Row>
                      <Col xs={6}>
                        <Button className="w-100" size="lg" onClick={previous}>
                          Previous
                        </Button>
                      </Col>
                      <Col xs={6}>
                        <Button
                          size="lg"
                          className="w-100"
                          disabled={this.isStepTwoNextDisabled()}
                          onClick={() => this.handleExchange(next)}
                        >
                          Next
                        </Button>
                      </Col>
                    </Row>
                  )}
                />
              </Step>
              <Step path="stepThree">
                <StepThree {...params} status={status} />
              </Step>
            </Steps>
          </Wizard>
        </Col>
      </Row>
    );
  }
}

export default CoinExchanger;
