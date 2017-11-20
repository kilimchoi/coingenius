const path = require('path');

module.exports = {
  resolve: {
    alias: {
      _bundles: path.resolve(__dirname, '../../app/javascript/bundles'),
    },
  },
};
