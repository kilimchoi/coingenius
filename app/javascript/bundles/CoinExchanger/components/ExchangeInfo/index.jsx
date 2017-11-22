import React, { Component } from 'react';
import FontAwesome from 'react-fontawesome';
import { wrapper, top, right, left, item, summary } from './styles.css';

class ExchangeInfo extends Component {
  render() {
    const {
      sendCurrency, receiveCurrency, sendAmount, receiveAmount,
    } = this.props;

    return (
      <div className={wrapper}>
        <div className={top}>
          <div className={summary}>
            <span className={item}>
              {sendAmount} {sendCurrency.symbol}
            </span>
            <span className={item}>
              <FontAwesome name="arrow-right" />
            </span>
            <span className={item}>
              {receiveAmount} {receiveCurrency.symbol}
            </span>
          </div>
        </div>
        <div className={left}>
          <p>Exchange rate</p>
          <p>
            1 {sendCurrency.symbol} = 0.223786 {receiveCurrency.symbol}
          </p>
        </div>
        <div className={right} />
      </div>
    );
  }
}

export default ExchangeInfo;
