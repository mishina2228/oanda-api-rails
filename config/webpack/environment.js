const { environment } = require('@rails/webpacker')

const sassLoader = environment.loaders.get('sass')
sassLoader.use.splice(-1, 0, {
  loader: 'resolve-url-loader'
})

environment.splitChunks()
module.exports = environment
