import React, { Component } from 'react';
import { Form, FormGroup, Label, Input, InputGroup, InputGroupAddon } from 'reactstrap';
import ExchangeInfo from '_bundles/CoinExchanger/components/ExchangeInfo';
import propTypes from '_bundles/CoinExchanger/propTypes';

class StepTwo extends Component {
  render() {
    const { sendingCoin, receiveCoin, onValueChange } = this.props;

    return (
      <div>
        <ExchangeInfo {...this.props} />
        <Form>
          <FormGroup>
            <Label for="withdrawalAddress">Your receive address</Label>
            <InputGroup>
              <InputGroupAddon>{sendingCoin.symbol}</InputGroupAddon>
              <Input
                name="withdrawalAddress"
                onChange={event => onValueChange('withdrawalAddress', event.target.value)}
              />
            </InputGroup>
          </FormGroup>
          <FormGroup>
            <Label for="returnAddress">Your refund address</Label>
            <InputGroup>
              <InputGroupAddon>{receiveCoin.symbol}</InputGroupAddon>
              <Input
                name="returnAddress"
                onChange={event => onValueChange('returnAddress', event.target.value)}
              />
            </InputGroup>
          </FormGroup>
        </Form>
      </div>
    );
  }
}

StepTwo.propTypes = {
  ...propTypes,
};

export default StepTwo;
