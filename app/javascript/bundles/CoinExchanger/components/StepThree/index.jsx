import React, { Component } from 'react';
import * as Clipboard from 'clipboard';
import { Col, ListGroup, ListGroupItem } from 'reactstrap';
import ClipboardLink from '_bundles/CoinExchanger/components/ClipboardLink';
import propTypes from '_bundles/CoinExchanger/propTypes';

class StepThree extends Component {
  constructor(props) {
    super(props);

    this.clipboard = new Clipboard('.copy-to-clipboard');
  }

  componentWillUnmount() {
    this.clipboard.destroy();
  }

  render() {
    const {
      sendingCoin, sendAmount, returnAddress, status,
    } = this.props;

    return (
      <div>
        <ListGroup>
          <ListGroupItem>
            <Col xs={2}>Amount</Col>
            <Col xs={8} id="amount">
              {sendAmount} {sendingCoin.symbol}
            </Col>
            <Col xs={2}>
              <ClipboardLink target="#amount" />
            </Col>
          </ListGroupItem>
          <ListGroupItem>
            <Col xs={2}>To address</Col>
            <Col xs={8} id="return-address">
              {returnAddress}
            </Col>
            <Col xs={2}>
              <ClipboardLink target="#return-address" />
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
