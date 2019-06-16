class UsdJpyM1CandleJob < CandleJob
  def self.perform(params = {})
    super(UsdJpyM1Candle, params)
  end
end
