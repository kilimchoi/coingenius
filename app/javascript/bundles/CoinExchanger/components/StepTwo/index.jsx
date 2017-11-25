import React, { Component } from 'react';
import { Form, FormGroup, Label, Input, InputGroup, InputGroupAddon } from 'reactstrap';
import ExchangeInfo from '_bundles/CoinExchanger/components/ExchangeInfo';
import InfoLabel from '_bundles/CoinExchanger/components/InfoLabel';
import propTypes from '_bundles/CoinExchanger/propTypes';
import { increasedHeightInput } from './styles.css';

class StepTwo extends Component {
  render() {
    const { sendingCoin, receiveCoin, onValueChange } = this.props;

    return (
      <div>
        <ExchangeInfo {...this.props} />
        <Form>
          <FormGroup>
            <Label for="withdrawalAddress">
              <InfoLabel>Your receive address</InfoLabel>
            </Label>
            <InputGroup>
              <InputGroupAddon>{sendingCoin.symbol}</InputGroupAddon>
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
              <InputGroupAddon>{receiveCoin.symbol}</InputGroupAddon>
              <Input
                className={increasedHeightInput}
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
