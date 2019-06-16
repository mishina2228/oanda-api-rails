class EurJpyM1CandleJob < CandleJob
  def self.perform(params = {})
    super(EurJpyM1Candle, params)
  end
end
