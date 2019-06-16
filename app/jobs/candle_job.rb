class CandleJob
  @queue = :normal

  def self.perform(klass, params = {})
    raise 'class must be specified' if klass.blank?
    raise 'class must be some candle-ish' unless klass.include?(CandleConcern)

    params = params.with_indifferent_access

    start = params[:start] || klass.latest_candle.time + klass::TIME_RANGE
    finish = params[:finish] || Time.zone.now
    count = params[:count] || 5000
    klass.save_numerous_candles(start: start, finish: finish, count: count)
  end
end
