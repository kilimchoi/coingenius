import React, { Component } from 'react';
import * as Clipboard from 'clipboard';
import { Col, ListGroup, ListGroupItem, Row } from 'reactstrap';
import FontAwesome from 'react-fontawesome';
import ClipboardLink from '_bundles/CoinExchanger/components/ClipboardLink';
import StatusProgress from '_bundles/CoinExchanger/components/StatusProgress';
import propTypes from '_bundles/CoinExchanger/propTypes';

class StepThree extends Component {
  constructor(props) {
    super(props);

    this.clipboard = new Clipboard('.copy-to-clipboard');
  }

  componentWillUnmount() {
    this.clipboard.destroy();
  }

  rateExpireAt() {
    const { rateExpiration } = this.props;

    return rateExpiration && new Date(rateExpiration).toLocaleString();
  }

  render() {
    const {
      currentState,
      sendingCoin,
      sendAmount,
      receiveAmount,
      depositAddress,
      receiveCoin,
    } = this.props;

    const rateExpireAt = this.rateExpireAt();

    return (
      <div>
        <ListGroup>
          <ListGroupItem>
            <Col xs={3}>Amount</Col>
            <Col xs={7} id="amount">
              {sendAmount} {sendingCoin.symbol}
            </Col>
            <Col xs={2}>
              <ClipboardLink target="#amount" />
            </Col>
          </ListGroupItem>
          <ListGroupItem>
            <Col xs={3}>To address</Col>
            <Col xs={7} id="return-address">
              {depositAddress || <FontAwesome name="spinner" spin />}
            </Col>
            <Col xs={2}>
              <ClipboardLink target="#return-address" />
            </Col>
          </ListGroupItem>
        </ListGroup>
        <Row className="mt-3 text-center">
          <Col xs={12}>
            <h5>
              {receiveAmount} {receiveCoin.symbol} will be sent to yor wallet.
            </h5>
            {rateExpireAt && (
              <p className="text-center">
                Current exchange rate will expire at {rateExpireAt}
              </p>
            )}
          </Col>
        </Row>
        <Row className="mt-3 justify-content-center">
          <StatusProgress currentState={currentState} />
        </Row>
      </div>
    );
  }
}

StepThree.propTypes = {
  ...propTypes,
};

export default StepThree;
