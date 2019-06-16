class GbpJpyM1CandleJob < CandleJob
  def self.perform(params = {})
    super(GbpJpyM1Candle, params)
  end
end
