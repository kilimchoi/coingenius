import React, { Component } from 'react';
import { Form, FormGroup, Label, Input, InputGroup, InputGroupAddon } from 'reactstrap';

class StepOne extends Component {
  render() {
    return (
      <Form>
        <FormGroup>
          <Label for="sendValue">You send</Label>
          <InputGroup>
            <Input name="sendValue" type="number" />
            <InputGroupAddon>
              <select name="sendCurrency">
                <option value="btc">BTC</option>
                <option value="eth">ETH</option>
                <option value="ltc">LTC</option>
              </select>
            </InputGroupAddon>
          </InputGroup>
        </FormGroup>
        <FormGroup>
          <Label for="receiveValue">You receive</Label>
          <InputGroup>
            <Input name="receiveValue" type="number" />
            <InputGroupAddon>
              <select name="receiveCurrency">
                <option value="btc">BTC</option>
                <option value="eth">ETH</option>
                <option value="ltc">LTC</option>
              </select>
            </InputGroupAddon>
          </InputGroup>
        </FormGroup>
      </Form>
    );
  }
}

export default StepOne;
