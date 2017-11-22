import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Form, FormGroup, Label, Input, InputGroup, InputGroupAddon } from 'reactstrap';
import CurrencyInput from '_bundles/CoinExchanger/components/CurrencyInput';

class StepOne extends Component {
  render() {
    const {
      onValueChange,
      sendAmount,
      receiveAmount,
      sendCurrency,
      receiveCurrency,
    } = this.props;

    return (
      <Form>
        <FormGroup>
          <Label for="sendAmount">You send</Label>
          <InputGroup>
            <Input
              name="sendAmount"
              type="number"
              value={sendAmount}
              onChange={event => onValueChange('sendAmount', event.target.value)}
            />
            <InputGroupAddon>
              <CurrencyInput
                value={sendCurrency}
                onChange={([currency]) => onValueChange('sendCurrency', currency)}
              />
            </InputGroupAddon>
          </InputGroup>
        </FormGroup>
        <FormGroup>
          <Label for="receiveAmount">You receive</Label>
          <InputGroup>
            <Input
              name="receiveAmount"
              type="number"
              value={receiveAmount}
              onChange={event => onValueChange('receiveAmount', event.target.value)}
            />
            <InputGroupAddon>
              <CurrencyInput
                value={receiveCurrency}
                onChange={([currency]) => onValueChange('receiveCurrency', currency)}
              />
            </InputGroupAddon>
          </InputGroup>
        </FormGroup>
      </Form>
    );
  }
}

StepOne.propTypes = {
  onValueChange: PropTypes.func.isRequired,
};

export default StepOne;
