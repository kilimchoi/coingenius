import React from 'react';
import PropTypes from 'prop-types';
import FontAwesome from 'react-fontawesome';
import { center } from './styles.css';

const Separator = ({ wrapperClass }) => (
  <div>
    <div className={wrapperClass}>
      <FontAwesome className={center} name="angle-right" size="2x" />
    </div>
  </div>
);

Separator.propTypes = {
  wrapperClass: PropTypes.string,
};

Separator.defaultProps = {
  wrapperClass: '',
};

export default Separator;
