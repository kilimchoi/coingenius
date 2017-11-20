const environment = require('./environment');
const addCssModules = require('./addCssModules');

addCssModules(environment);

module.exports = environment.toWebpackConfig();
