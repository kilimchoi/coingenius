import React, { Component } from 'react';
import FontAwesome from 'react-fontawesome';
import { Col, ListGroup, ListGroupItem } from 'reactstrap';
import propTypes from '_bundles/CoinExchanger/propTypes';

const JAVASCRIPT_HREF = 'javascript:;';

class StepThree extends Component {
  render() {
    const {
      sendingCoin, sendAmount, returnAddress, status,
    } = this.props;

    return (
      <div>
        <ListGroup>
          <ListGroupItem>
            <Col xs={2}>Amount</Col>
            <Col xs={8}>
              {sendAmount} {sendingCoin.symbol}
            </Col>
            <Col xs={2}>
              <a href={JAVASCRIPT_HREF}>
                <FontAwesome name="clipboard" />
              </a>
            </Col>
          </ListGroupItem>
          <ListGroupItem>
            <Col xs={2}>To address</Col>
            <Col xs={8}>{returnAddress}</Col>
            <Col xs={2}>
              <a href={JAVASCRIPT_HREF}>
                <FontAwesome name="clipboard" />
              </a>
            </Col>
          </ListGroupItem>
        </ListGroup>
        <h3>{status}</h3>
      </div>
    );
  }
}

StepThree.propTypes = {
  ...propTypes,
};

export default StepThree;
