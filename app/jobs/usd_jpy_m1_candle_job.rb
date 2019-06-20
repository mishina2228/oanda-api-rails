class UsdJpyM1CandleJob < CandleJob
  @queue = :normal

  def self.perform(params = {})
    super(UsdJpyM1Candle, params)
  end
end
