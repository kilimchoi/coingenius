const path = require('path');

module.exports = {
  resolve: {
    alias: {
      _bundles: path.resolve(__dirname, '../../app/javascript/bundles'),
      _lib: path.resolve(__dirname, '../../app/javascript/lib'),
      _sources: path.resolve(__dirname, '../../app/javascript/sources'),
    },
  },
};
