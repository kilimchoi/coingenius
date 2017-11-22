import React, { Component } from 'react';
import FontAwesome from 'react-fontawesome';
import { bottomInnerWrapper, centered, wrapper, pane, right, left, item } from './styles.css';

class ExchangeInfo extends Component {
  render() {
    const {
      sendCurrency,
      receiveCurrency,
      sendAmount,
      receiveAmount,
    } = this.props;

    return (
      <div className={wrapper}>
        <div className={pane}>
          <div className={centered}>
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
        <div className={`${pane} ${left}`}>
          <div className={`${centered} ${bottomInnerWrapper}`}>
            <p>Exchange rate</p>
            1 {sendCurrency.symbol} = 0.223786 {receiveCurrency.symbol}
          </div>
        </div>
        <div className={`${pane} ${right}`}>
          <div className={`${centered} ${bottomInnerWrapper}`}>
            <p>FEE (INC)</p>
            0.5%
          </div>
        </div>
      </div>
    );
  }
}

export default ExchangeInfo;
