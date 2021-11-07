const { webpackConfig, merge } = require('@rails/webpacker')

// https://github.com/rails/webpacker/issues/2844
webpackConfig.module.rules.map(module => {
  if (module.test && module.test.toString().includes('scss')) {
    module.use.splice(-1, 0, {
      loader: require.resolve('resolve-url-loader')
    })
  }
  return module
})
// sassLoader.use.splice(-1, 0, {
//   loader: 'resolve-url-loader'
// })
// webpackConfig.loaders.prepend('erb', erb)

// const webpack = require('webpack')
// environment.plugins.append('Provide',
//   new webpack.ProvidePlugin({
//     $: 'jquery',
//     jQuery: 'jquery'
//   })
// )

const customConfig = {
  resolve: {
    alias: {
      $: 'jquery/src/jquery',
      jQuery: 'jquery/src/jquery'
    },
    extensions: ['.css', '.scss']
  }
}
const erb = require('./loaders/erb')

module.exports = merge(webpackConfig, customConfig)
