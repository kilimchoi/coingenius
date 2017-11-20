import React, { Component } from 'react';
import { Form, FormGroup, Label, Input, InputGroup, InputGroupAddon } from 'reactstrap';
import ExchangeInfo from '_bundles/CoinExchanger/components/ExchangeInfo';

class StepTwo extends Component {
  render() {
    return (
      <div>
        <ExchangeInfo />
        <Form>
          <FormGroup>
            <Label for="receiveAddress">Your receive address</Label>
            <InputGroup>
              <InputGroupAddon>BTC</InputGroupAddon>
              <Input name="receiveAddress" />
            </InputGroup>
          </FormGroup>
          <FormGroup>
            <Label for="refundAddress">Your refund address</Label>
            <InputGroup>
              <InputGroupAddon>LTC</InputGroupAddon>
              <Input name="refundAddress" />
            </InputGroup>
          </FormGroup>
        </Form>
      </div>
    );
  }
}

export default StepTwo;
