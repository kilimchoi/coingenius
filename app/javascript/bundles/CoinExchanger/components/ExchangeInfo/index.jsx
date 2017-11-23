import React, { Component } from 'react';
import FontAwesome from 'react-fontawesome';
import propTypes from '_bundles/CoinExchanger/propTypes';
import { bottomInnerWrapper, centered, wrapper, pane, right, left, item } from './styles.css';

class ExchangeInfo extends Component {
  render() {
    const {
      rate, sendingCoin, receiveCoin, sendAmount, receiveAmount,
    } = this.props;

    return (
      <div className={wrapper}>
        <div className={pane}>
          <div className={centered}>
            <span className={item}>
              {sendAmount} {sendingCoin.symbol}
            </span>
            <span className={item}>
              <FontAwesome name="arrow-right" />
            </span>
            <span className={item}>
              {receiveAmount} {receiveCoin.symbol}
            </span>
          </div>
        </div>
        <div className={`${pane} ${left}`}>
          <div className={`${centered} ${bottomInnerWrapper}`}>
            <p>Exchange rate</p>
            1 {sendingCoin.symbol} = {rate} {receiveCoin.symbol}
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

ExchangeInfo.propTypes = {
  ...propTypes,
};

export default ExchangeInfo;
