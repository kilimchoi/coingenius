import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { AsyncTypeahead } from 'react-bootstrap-typeahead';
import { getCoinNames } from '_sources/transactions';
import { currencyInputWrapper, input } from './styles.css';

class CurrencyInput extends Component {
  constructor(props) {
    super(props);

    this.state = {
      isLoading: false,
      options: [],
    };
  }

  onSearch = (term) => {
    this.setState({ isLoading: true });
    getCoinNames(term).then(({ serializedBody: allOptions }) => {
      const options = allOptions.filter(({ shapeshiftConvertible }) => shapeshiftConvertible);

      this.setState({ options });
    });
  };

  render() {
    const { isLoading, options } = this.state;
    const { onChange, value } = this.props;
    const selectedLabel = (value && value.label && [value]) || [];

    return (
      <div className={currencyInputWrapper}>
        <AsyncTypeahead
          className="typeahead-wrapper"
          inputProps={{ className: input }}
          isLoading={isLoading}
          onChange={onChange}
          onSearch={this.onSearch}
          options={options}
          placeholder="Type to search coin..."
          selected={selectedLabel}
        />
      </div>
    );
  }
}

CurrencyInput.propTypes = {
  onChange: PropTypes.func.isRequired,
  value: PropTypes.object,
};

CurrencyInput.defaultProps = {
  value: {},
};

export default CurrencyInput;
