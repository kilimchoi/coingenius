import React, { Component } from 'react';
import { Col, Row } from 'reactstrap';
import { Wizard, Step, Steps } from 'react-albus';
import { decamelizeKeys } from 'humps';
import promisePoller from 'promise-poller';
import { createConversion, fetchConversion } from '_sources/convertions';
import { getCoins } from '_sources/coins';
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
const initialState = {
  rate: 1.0,
  sendAmount: 0.01,
  sendingCoin: {
    id: 1,
    name: 'Bitcoin',
    symbol: 'BTC',
    shapeshiftConvertible: true,
  },
  receiveCoin: {
    id: 2,
    name: 'Ethereum',
    symbol: 'ETH',
    shapeshiftConvertible: true,
  },
  withdrawalAddress: '',
  returnAddress: '',
  currentState: 'pending',
  coins: [],
};

class CoinExchanger extends Component {
  constructor(props) {
    super(props);

    this.state = initialState;
  }

  componentDidMount() {
    getCoins()
      .then(({ serializedBody: options }) =>
        options.filter(({ shapeshiftConvertible }) => shapeshiftConvertible))
      .then(coins => this.setState({ coins }));
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
    this.createConversionAndSetId().then(this.pollConversionStatus);
  };

  createConversionAndSetId = () => {
    const {
      sendAmount: amount,
      sendingCoin: { id: sendingCoinId },
      receiveCoin: { id: receiveCoinId },
      returnAddress,
      withdrawalAddress,
    } = this.state;
    const params = decamelizeKeys({
      amount,
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
      const taskFn = () =>
        fetchConversion(conversionId).then(({ serializedBody: { currentState } }) => {
          this.setState({ currentState });

          return currentState;
        });

      promisePoller({
        interval: 500,
        retries: 3,
        shouldContinue: (error, status) => error || !TERMINAL_STATUSES.includes(status),
        taskFn,
      });
    }
  };

  switchCoins(prevState) {
    const { sendingCoin, receiveCoin } = this.state;
    const areCoinsEqual = sendingCoin && receiveCoin && sendingCoin.id === receiveCoin.id;

    if (areCoinsEqual) {
      this.setState({ sendingCoin: prevState.receiveCoin, receiveCoin: prevState.sendingCoin });
    }
  }

  render() {
    const {
      currentState, sendAmount, rate, coins,
    } = this.state;
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
                <StepOne {...params} coins={coins} />
              </Step>
              <Step path="stepTwo">
                <StepTwo {...params} onExchange={this.handleExchange} />
              </Step>
              <Step path="stepThree">
                <StepThree {...params} currentState={currentState} />
              </Step>
            </Steps>
          </Wizard>
        </Col>
      </Row>
    );
  }
}

export default CoinExchanger;
