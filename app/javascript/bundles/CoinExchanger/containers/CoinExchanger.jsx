import React, { Component, PureComponent } from 'react';
import { Col, Row } from 'reactstrap';
import { Wizard, Step, Steps } from 'react-albus';
import { decamelizeKeys } from 'humps';
import debounce from 'lodash.debounce';
import promisePoller from 'promise-poller';
import { createConversion, buildConversion, fetchConversion } from '_sources/convertions';
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

class CoinExchanger extends PureComponent {
  constructor(props) {
    super(props);

    this.state = initialState;
  }

  componentDidMount() {
    this.fetchCoins().then(this.fetchRate);
  }

  componentDidUpdate(prevProps, prevState) {
    if (this.areCoinsEqual()) {
      this.switchCoins(prevState);
    }

    if (this.areCoinsChanged(prevState)) {
      this.fetchRate();
    }
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

  fetchCoins = () =>
    getCoins()
      .then(({ serializedBody: options }) =>
        options.filter(({ shapeshiftConvertible }) => shapeshiftConvertible))
      .then(coins => this.setState({ coins }));

  fetchRate = debounce(() => {
    const { sendingCoin, receiveCoin } = this.state;

    if (sendingCoin.id && receiveCoin.id) {
      const params = decamelizeKeys({
        receiveCoinId: receiveCoin.id,
        sendingCoinId: sendingCoin.id,
      });

      buildConversion(params).then(({ serializedBody: { rate, maxAmount, minAmount } }) => {
        this.setState({
          rate,
          maxAmount,
          minAmount,
        });
      });
    }
  }, 300);

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
    this.setState(
      { sendingCoin: prevState.receiveCoin, receiveCoin: prevState.sendingCoin },
      this.fetchRate,
    );
  }

  areCoinsChanged = prevState =>
    this.state.sendingCoin.id !== this.state.receiveCoin.id &&
    (prevState.sendingCoin.id !== this.state.sendingCoin.id ||
      prevState.receiveCoin.id !== this.state.receiveCoin.id);

  areCoinsEqual = () => {
    const { sendingCoin, receiveCoin } = this.state;
    return sendingCoin && receiveCoin && sendingCoin.id === receiveCoin.id;
  };

  render() {
    const {
      currentState, sendAmount, rate, coins, maxAmount, minAmount,
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
                <StepOne {...params} coins={coins} maxAmount={maxAmount} minAmount={minAmount} />
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
