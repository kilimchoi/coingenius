import PropTypes from 'prop-types';

export default {
  currentState: PropTypes.string.isRequired,
  rate: PropTypes.number.isRequired,
  sendAmount: PropTypes.number.isRequired,
  sendingCoin: PropTypes.object.isRequired,
  receiveCoin: PropTypes.object.isRequired,
};
