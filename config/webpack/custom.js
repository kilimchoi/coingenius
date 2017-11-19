const {
  addPlugins,
  babel,
  createConfig,
  css,
  defineConstants,
  devServer,
  entryPoint,
  env,
  match,
  performance,
  resolve,
  setOutput,
  sourceMaps
} = require('webpack-blocks');
const path = require('path');
const moduleRegistrationPath = path.resolve(__dirname, '../../app/javascript/packs/module_registration.js')

const config = createConfig([
  entryPoint({
    'app-bundle': moduleRegistrationPath,
  }),
  setOutput({
    filename: '[name].js',
    path: path.resolve(__dirname, '../../public/packs'),
    chunkFilename: '[id].[chunkhash].js'
    }),
  babel(),
  match('*.css', { exclude: path.resolve('node_modules') }, [
    css(),
    css.modules()
  ]),
  defineConstants({
    'process.env.NODE_ENV': process.env.NODE_ENV,
  }),
  resolve({
    alias: {
      _bundles: path.resolve(__dirname, '../../app/javascript/bundles'),
    }
  }),
  env('development', [
    devServer(),
    sourceMaps(),
    performance({
      maxAssetSize: 1500000,
      maxEntrypointSize: 1500000,
    }),
  ])
]);

module.exports = config;
