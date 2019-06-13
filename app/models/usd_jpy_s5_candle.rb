class UsdJpyS5Candle < ApplicationRecord
  include CandleConcern

  GRANULARITY = OandaAPI::Resource::Candle::Granularity::S5
  TIME_RANGE = 5.seconds
  INSTRUMENT = :USD_JPY
end
