import React from 'react';
import PropTypes from 'prop-types';
import FontAwesome from 'react-fontawesome';
import classNames from 'classnames/bind';
import styles from './styles.css';

const { center } = styles;
const cx = classNames.bind(styles);
const StatusIcon = ({
  iconName, wrapperClass, text, enabled,
}) => (
  <div>
    <div className={cx(wrapperClass, { enabled })}>
      <FontAwesome
        className={cx(center, { spinnerFix: !enabled })}
        name={(enabled && iconName) || 'spinner'}
        size="2x"
        spin={!enabled}
      />
    </div>
    <p className="text-uppercase">{text}</p>
  </div>
);

StatusIcon.propTypes = {
  iconName: PropTypes.string.isRequired,
  enabled: PropTypes.bool.isRequired,
  text: PropTypes.string,
  wrapperClass: PropTypes.string,
};

StatusIcon.defaultProps = {
  wrapperClass: '',
  text: null,
};

export default StatusIcon;
