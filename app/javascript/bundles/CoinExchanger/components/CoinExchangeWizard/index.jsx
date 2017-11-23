import React, { Component } from 'react';
import { Button, Container } from 'reactstrap';
import { Wizard, Step, Steps, Navigation } from 'react-albus';
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

class CoinExchanger extends Component {
  constructor(props) {
    super(props);

    this.state = {
      rate: 1.0,
      sendAmount: 0.0,
      sendingCoin: { ...defaultCoin },
      receiveCoin: { ...defaultCoin },
      receiveAddress: '',
      refundAddress: '',
    };
  }

  handleValueChange = (name, value) => {
    this.setState({
      [name]: coerceProxy[name](value),
    });
  };

  isStepOneNextDisabled = () => {
    const { sendAmount, sendingCoin, receiveCoin } = this.state;

    return !(sendAmount && sendingCoin && receiveCoin && sendingCoin.id && receiveCoin.id);
  };

  isStepTwoNextDisabled = () => {
    const { receiveAddress, refundAddress } = this.state;

    return !(receiveAddress && refundAddress);
  };

  render() {
    const { sendAmount, rate } = this.state;
    const receiveAmount = sendAmount * rate;
    const params = {
      onValueChange: this.handleValueChange,
      receiveAmount,
      ...this.state,
    };

    return (
      <Container fluid>
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
                      <Button disabled={this.isStepTwoNextDisabled()} size="lg" onClick={next}>
                        Next
                      </Button>
                    </div>
                  </div>
                )}
              />
            </Step>
            <Step path="stepThree">
              <StepThree {...params} />
            </Step>
          </Steps>
        </Wizard>
      </Container>
    );
  }
}

export default CoinExchanger;
