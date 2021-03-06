const merge = require('webpack-merge');

const myCssLoaderOptions = {
  modules: true,
  sourceMap: true,
  localIdentName: '[name]__[local]___[hash:base64:5]',
};

function addCssModules(environment) {
  const CSSLoader = environment.loaders.get('style').use.find(el => el.loader === 'css-loader');

  CSSLoader.options = merge(CSSLoader.options, myCssLoaderOptions);

  return CSSLoader;
}

module.exports = addCssModules;
