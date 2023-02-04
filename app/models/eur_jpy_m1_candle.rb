# frozen_string_literal: true

class EurJpyM1Candle < ApplicationRecord
  include CandleConcern

  GRANULARITY = OandaAPI::Resource::Candle::Granularity::M1
  TIME_RANGE = 1.minute
  INSTRUMENT = :EUR_JPY
end
