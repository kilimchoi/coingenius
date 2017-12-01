import React, { Component } from 'react';
import { findDOMNode } from 'react-dom';
import PropTypes from 'prop-types';
import { Button, Form, FormGroup, Label, Input, InputGroup, InputGroupAddon } from 'reactstrap';
import { Navigation } from 'react-albus';
import CurrencyInput from '_bundles/CoinExchanger/components/CurrencyInput';
import InfoLabel from '_bundles/CoinExchanger/components/InfoLabel';
import propTypes from '_bundles/CoinExchanger/propTypes';
import { disabledInput } from './styles.css';

class StepOne extends Component {
  constructor(props) {
    super(props);

    this.sendAmountInput = null;
  }

  handleCurrencyChange = (name, value) => {
    if (value && this.props[name] !== value) {
      this.props.onValueChange(name, value);
    }
  };

  allCurrenciesPresent = () => {
    const { sendingCoin, receiveCoin } = this.props;

    return sendingCoin && receiveCoin;
  };

  areCoinsPresent = () => {
    const { sendAmount, sendingCoin, receiveCoin } = this.props;

    return sendAmount && sendingCoin && receiveCoin && sendingCoin.id && receiveCoin.id;
  };

  isSendInputValid = () => this.sendAmountInput && this.sendAmountInput.checkValidity();

  isNextDisabled = () => !this.areCoinsPresent() || !this.isSendInputValid();

  render() {
    const {
      coins,
      maxAmount,
      minAmount,
      onValueChange,
      sendAmount,
      sendingCoin,
      receiveCoin,
      receiveAmount,
    } = this.props;

    const inputConstraints = { max: maxAmount, min: minAmount };

    return (
      <div>
        <Form>
          <FormGroup>
            <Label for="sendAmount">
              <InfoLabel
                iconId="sending"
                tooltipText="Send this amount to the address we provide in the last step"
              >
                You send
              </InfoLabel>
            </Label>
            <div className="pull-right">
              Min {minAmount}
              {' | '}
              Max {maxAmount}
            </div>
            <InputGroup>
              <Input
                {...inputConstraints}
                name="sendAmount"
                type="number"
                step="0.0001"
                value={sendAmount}
                ref={(input) => {
                  this.sendAmountInput = findDOMNode(input);
                }}
                onChange={event => onValueChange('sendAmount', event.target.value)}
              />
              <InputGroupAddon>
                <CurrencyInput
                  value={sendingCoin}
                  options={coins}
                  onChange={([currency]) => this.handleCurrencyChange('sendingCoin', currency)}
                />
              </InputGroupAddon>
            </InputGroup>
          </FormGroup>
          <FormGroup>
            <Label for="receiveAmount">
              <InfoLabel
                iconId="receive"
                tooltipText="This amount will be sent to you after we exchange the coins"
              >
                You receive
              </InfoLabel>
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
                  options={coins}
                  onChange={([currency]) => this.handleCurrencyChange('receiveCoin', currency)}
                />
              </InputGroupAddon>
            </InputGroup>
          </FormGroup>
        </Form>
        <Navigation
          render={({ next }) => (
            <div>
              <Button className="w-100" disabled={this.isNextDisabled()} size="lg" onClick={next}>
                Next
              </Button>
            </div>
          )}
        />
      </div>
    );
  }
}

StepOne.propTypes = {
  onValueChange: PropTypes.func.isRequired,
  coins: PropTypes.array.isRequired,
  ...propTypes,
};

export default StepOne;
