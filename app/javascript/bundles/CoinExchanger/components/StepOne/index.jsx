import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {
  Button,
  Form,
  FormGroup,
  FormFeedback,
  Label,
  Input,
  InputGroup,
  InputGroupAddon,
} from 'reactstrap';
import { Navigation } from 'react-albus';
import CurrencyInput from '_bundles/CoinExchanger/components/CurrencyInput';
import InfoLabel from '_bundles/CoinExchanger/components/InfoLabel';
import propTypes from '_bundles/CoinExchanger/propTypes';
import { error, disabledInput } from './styles.css';

class StepOne extends Component {
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

  isSendInputValid = () => {
    const { sendAmount, maxAmount, minAmount } = this.props;

    return !maxAmount || (sendAmount >= minAmount && sendAmount <= maxAmount);
  };

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
          <p>
            Note: This is an approximate rate, you will see the precise amount on the final step.
          </p>
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
              Min {minAmount || 'N/A'}
              {' | '}
              Max {maxAmount || 'N/A'}
            </div>
            <InputGroup>
              <Input
                {...inputConstraints}
                valid={this.isSendInputValid()}
                name="sendAmount"
                type="number"
                step="0.0001"
                value={sendAmount}
                onChange={(event) => {
                  onValueChange('sendAmount', event.target.value);
                  this.isSendInputValid();
                }}
              />
              <InputGroupAddon>
                <CurrencyInput
                  value={sendingCoin}
                  options={coins}
                  onChange={([currency]) => this.handleCurrencyChange('sendingCoin', currency)}
                />
              </InputGroupAddon>
            </InputGroup>
            {!this.isSendInputValid() && (
              <FormFeedback className={`mt-1 ${error}`}>
                Send amount should be in range between {minAmount} and {maxAmount}
              </FormFeedback>
            )}
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
                value={receiveAmount || sendAmount}
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
