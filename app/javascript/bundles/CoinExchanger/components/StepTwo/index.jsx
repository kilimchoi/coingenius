import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Navigation } from 'react-albus';
import {
  Form,
  FormGroup,
  Label,
  Input,
  InputGroup,
  InputGroupAddon,
  Row,
  Col,
  Button,
} from 'reactstrap';
import ExchangeInfo from '_bundles/CoinExchanger/components/ExchangeInfo';
import InfoLabel from '_bundles/CoinExchanger/components/InfoLabel';
import propTypes from '_bundles/CoinExchanger/propTypes';
import { increasedHeightInput } from './styles.css';

class StepTwo extends Component {
  isNextDisabled = () => {
    const { withdrawalAddress, returnAddress } = this.props;

    return !(withdrawalAddress && returnAddress);
  };

  handleExchange = (next) => {
    next();
    this.createConversionAndSetId().then(this.pollConversionStatus);
  };

  render() {
    const {
      sendingCoin, receiveCoin, onValueChange, onExchange,
    } = this.props;

    return (
      <div>
        <ExchangeInfo {...this.props} />
        <Form>
          <FormGroup>
            <Label for="withdrawalAddress">
              <InfoLabel>Your receive address</InfoLabel>
            </Label>
            <InputGroup>
              <InputGroupAddon>{receiveCoin.symbol}</InputGroupAddon>
              <Input
                className={increasedHeightInput}
                name="withdrawalAddress"
                onChange={event => onValueChange('withdrawalAddress', event.target.value)}
              />
            </InputGroup>
          </FormGroup>
          <FormGroup>
            <Label for="returnAddress">
              <InfoLabel>Your refund address</InfoLabel>
            </Label>
            <InputGroup>
              <InputGroupAddon>{sendingCoin.symbol}</InputGroupAddon>
              <Input
                className={increasedHeightInput}
                name="returnAddress"
                onChange={event => onValueChange('returnAddress', event.target.value)}
              />
            </InputGroup>
          </FormGroup>
        </Form>
        <Navigation
          render={({ next, previous }) => (
            <Row>
              <Col xs={6}>
                <Button className="w-100" size="lg" onClick={previous}>
                  Previous
                </Button>
              </Col>
              <Col xs={6}>
                <Button
                  size="lg"
                  className="w-100"
                  disabled={this.isNextDisabled()}
                  onClick={() => onExchange(next)}
                >
                  Next
                </Button>
              </Col>
            </Row>
          )}
        />
      </div>
    );
  }
}

StepTwo.propTypes = {
  ...propTypes,
  onExchange: PropTypes.func.isRequired,
};

export default StepTwo;
