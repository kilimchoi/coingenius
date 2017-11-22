import React, { Component } from 'react';
import { Form, FormGroup, Label, Input, InputGroup, InputGroupAddon } from 'reactstrap';
import ExchangeInfo from '_bundles/CoinExchanger/components/ExchangeInfo';

class StepTwo extends Component {
  render() {
    const { sendCurrency, receiveCurrency } = this.props;

    return (
      <div>
        <ExchangeInfo {...this.props} />
        <Form>
          <FormGroup>
            <Label for="receiveAddress">Your receive address</Label>
            <InputGroup>
              <InputGroupAddon>{sendCurrency.symbol}</InputGroupAddon>
              <Input name="receiveAddress" />
            </InputGroup>
          </FormGroup>
          <FormGroup>
            <Label for="refundAddress">Your refund address</Label>
            <InputGroup>
              <InputGroupAddon>{receiveCurrency.symbol}</InputGroupAddon>
              <Input name="refundAddress" />
            </InputGroup>
          </FormGroup>
        </Form>
      </div>
    );
  }
}

export default StepTwo;
