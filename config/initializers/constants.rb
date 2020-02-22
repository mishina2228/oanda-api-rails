module Constants
  module Mishina
    OANDA_TOKEN_PATH = Rails.root.join('config/token.yml')
    CANDLE_FORMATS = {
      bidask: OandaAPI::Resource::Candle::Format::BIDASK,
      midpoint: OandaAPI::Resource::Candle::Format::MIDPOINT
    }.freeze
    GRANULARITIES =
      OandaAPI::Resource::Candle::Granularity::VALID_GRANULARITIES.map {|g| [g.to_sym, g]}.to_h
    INSTRUMENTS = {
      EUR_JPY = :EUR_JPY => :EUR_JPY,
      GBP_JPY = :GBP_JPY => :GBP_JPY,
      USD_JPY = :USD_JPY => :USD_JPY
    }.freeze
  end
end
