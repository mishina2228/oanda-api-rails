const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')

const sassLoader = environment.loaders.get('sass')
sassLoader.use.splice(-1, 0, {
  loader: 'resolve-url-loader'
})
environment.loaders.prepend('erb', erb)

environment.splitChunks()
module.exports = environment
