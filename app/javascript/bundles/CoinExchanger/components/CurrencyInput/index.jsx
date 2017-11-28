import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Typeahead } from 'react-bootstrap-typeahead';
import { currencyInputWrapper, input } from './styles.css';

class CurrencyInput extends Component {
  render() {
    const { onChange, value, options } = this.props;

    return (
      <div className={currencyInputWrapper}>
        <Typeahead
          className="typeahead-wrapper"
          inputProps={{ className: input }}
          labelKey="name"
          onChange={onChange}
          options={options}
          placeholder="Type to search coin..."
          selected={[value]}
        />
      </div>
    );
  }
}

CurrencyInput.propTypes = {
  onChange: PropTypes.func.isRequired,
  options: PropTypes.array.isRequired,
  value: PropTypes.object,
};

CurrencyInput.defaultProps = {
  value: {},
};

export default CurrencyInput;
