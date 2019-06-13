class GbpJpyM1Candle < ApplicationRecord
  include CandleConcern

  GRANULARITY = OandaAPI::Resource::Candle::Granularity::M1
  TIME_RANGE = 1.minute
  INSTRUMENT = :GBP_JPY
end
