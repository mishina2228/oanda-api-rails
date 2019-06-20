class EurJpyM1CandleJob < CandleJob
  @queue = :normal

  def self.perform(params = {})
    super(EurJpyM1Candle, params)
  end
end
