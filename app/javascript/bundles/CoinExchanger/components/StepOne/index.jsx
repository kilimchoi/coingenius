import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Form, FormGroup, Label, Input, InputGroup, InputGroupAddon } from 'reactstrap';
import { decamelizeKeys } from 'humps';
import CurrencyInput from '_bundles/CoinExchanger/components/CurrencyInput';
import InfoLabel from '_bundles/CoinExchanger/components/InfoLabel';
import propTypes from '_bundles/CoinExchanger/propTypes';
import { buildConversion } from '_sources/convertions';
import { disabledInput } from './styles.css';

class StepOne extends Component {
  constructor(props) {
    super(props);

    this.fetchRate();
  }

  handleCurrencyChange = (name, value) => {
    if (value) {
      this.props.onValueChange(name, value);
      this.fetchRate();
    }
  };

  fetchRate = () => {
    const { onValueChange, sendingCoin, receiveCoin } = this.props;

    if (sendingCoin && receiveCoin && sendingCoin.id && receiveCoin.id) {
      const params = decamelizeKeys({
        receiveCoinId: receiveCoin.id,
        sendingCoinId: sendingCoin.id,
      });

      buildConversion(params).then(({ serializedBody: { rate } }) => {
        onValueChange('rate', rate);
      });
    }
  };

  allCurrenciesPresent = () => {
    const { sendingCoin, receiveCoin } = this.props;

    return sendingCoin && receiveCoin;
  };

  render() {
    const {
      onValueChange, sendAmount, sendingCoin, receiveCoin, receiveAmount,
    } = this.props;

    return (
      <Form>
        <FormGroup>
          <Label for="sendAmount">
            <InfoLabel>You send</InfoLabel>
          </Label>
          <InputGroup>
            <Input
              name="sendAmount"
              type="number"
              step="0.01"
              value={sendAmount}
              onChange={event => onValueChange('sendAmount', event.target.value)}
            />
            <InputGroupAddon>
              <CurrencyInput
                value={sendingCoin}
                onChange={([currency]) => this.handleCurrencyChange('sendingCoin', currency)}
              />
            </InputGroupAddon>
          </InputGroup>
        </FormGroup>
        <FormGroup>
          <Label for="receiveAmount">
            <InfoLabel>You receive</InfoLabel>
          </Label>
          <InputGroup>
            <Input
              disabled
              className={disabledInput}
              name="receiveAmount"
              type="number"
              step="0.01"
              value={receiveAmount}
              onChange={event => onValueChange('receiveAmount', event.target.value)}
            />
            <InputGroupAddon>
              <CurrencyInput
                value={receiveCoin}
                onChange={([currency]) => this.handleCurrencyChange('receiveCoin', currency)}
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
  ...propTypes,
};

export default StepOne;
