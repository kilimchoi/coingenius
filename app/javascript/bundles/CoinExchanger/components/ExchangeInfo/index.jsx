import React, { Component } from 'react';
import { Container, Col, Row } from 'reactstrap';
import FontAwesome from 'react-fontawesome';
import propTypes from '_bundles/CoinExchanger/propTypes';
import { borderBottom, borderRight, wrapper, pane, item } from './styles.css';

class ExchangeInfo extends Component {
  render() {
    const {
      rate, sendingCoin, receiveCoin, sendAmount, receiveAmount,
    } = this.props;

    return (
      <Container className={`wt-100 ${wrapper}`}>
        <Row className={`justify-content-center align-items-center ${pane} ${borderBottom}`}>
          <Col xs={12} className="text-center">
            <span className={item}>
              {sendAmount} {sendingCoin.symbol}
            </span>
            <span className={item}>
              <FontAwesome name="arrow-right" />
            </span>
            <span className={item}>
              {receiveAmount} {receiveCoin.symbol}
            </span>
          </Col>
        </Row>
        <Row className={`justify-content-center align-items-center ${pane}`}>
          <Col xs={6} className={`text-center h-100 pt-4 ${borderRight}`}>
            <p>Exchange rate</p>
            1 {sendingCoin.symbol} = {rate} {receiveCoin.symbol}
          </Col>
          <Col xs={6} className="text-center pt-4 h-100">
            <p>
              <strong>FEE (INC)</strong>
            </p>
            0.5%
          </Col>
        </Row>
      </Container>
    );
  }
}

ExchangeInfo.propTypes = {
  ...propTypes,
};

export default ExchangeInfo;
