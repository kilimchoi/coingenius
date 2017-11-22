import React, { Component } from 'react';
import FontAwesome from 'react-fontawesome';
import { Col, ListGroup, ListGroupItem } from 'reactstrap';

class StepThree extends Component {
  render() {
    const {
      sendCurrency, receiveCurrency, sendAmount, receiveAmount, refundAddress,
    } = this.props;

    return (
      <div>
        <ListGroup>
          <ListGroupItem>
            <Col xs={2}>Amount</Col>
            <Col xs={8}>
              {sendAmount} {sendCurrency.symbol}
            </Col>
            <Col xs={2}>
              <a href="#"><FontAwesome name="clipboard" /></a>
            </Col>
          </ListGroupItem>
          <ListGroupItem>
            <Col xs={2}>To address</Col>
            <Col xs={8}>{refundAddress}</Col>
            <Col xs={2}>
              <a href="#"><FontAwesome name="clipboard" /></a>
            </Col>
          </ListGroupItem>
        </ListGroup>
      </div>
    );
  }
}

export default StepThree;
