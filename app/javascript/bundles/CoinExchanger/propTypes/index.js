import PropTypes from 'prop-types';

export default {
  currentState: PropTypes.string.isRequired,
  sendAmount: PropTypes.number.isRequired,
  sendingCoin: PropTypes.object.isRequired,
  receiveCoin: PropTypes.object.isRequired,
};
