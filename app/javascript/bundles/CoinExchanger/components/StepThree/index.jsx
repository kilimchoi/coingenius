import React, { Component } from 'react';
import { Col, ListGroup, ListGroupItem } from 'reactstrap';

class StepThree extends Component {

  render() {
    return (
      <div>
        <ListGroup>
          <ListGroupItem>
            <Col xs={2}>Amount</Col>
            <Col xs={8}>0.1 BTC</Col>
            <Col xs={2}>Copy</Col>
          </ListGroupItem>
          <ListGroupItem>
            <Col xs={2}>To address</Col>
            <Col xs={8}>d641dc053d16b6f83c05addfd1f305c4a785913ec706</Col>
            <Col xs={2}>Copy</Col>
          </ListGroupItem>
        </ListGroup>
      </div>
    );
  }

}

export default StepThree;
