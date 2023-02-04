# frozen_string_literal: true

class GbpJpyM1CandleJob < CandleJob
  @queue = :normal

  def self.perform(params = {})
    super(GbpJpyM1Candle, params)
  end
end
