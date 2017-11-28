const merge = require('webpack-merge');
const environment = require('./environment');
const customConfig = require('./custom');
const addCssModules = require('./addCssModules');

addCssModules(environment);

module.exports = merge(environment.toWebpackConfig(), customConfig);
