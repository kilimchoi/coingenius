import PropTypes from 'prop-types';

export default {
  rate: PropTypes.number.isRequired,
  sendAmount: PropTypes.number.isRequired,
  sendingCoin: PropTypes.object.isRequired,
  receiveCoin: PropTypes.object.isRequired,
};
