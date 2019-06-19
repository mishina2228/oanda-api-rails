class CandleJob
  @queue = :normal

  def self.before_enqueue(params = {})
    jobs = Resque.peek(@queue, 0, 100)
    jobs.each do |job|
      return false if job['class'] == name
    end
    true
  end

  def self.perform(klass, params = {})
    raise 'class must be specified' if klass.blank?
    raise 'class must be some candle-ish' unless klass.include?(CandleConcern)

    params = params.with_indifferent_access

    start = params[:start] || klass.latest_candle.time + klass::TIME_RANGE
    finish = params[:finish] || Time.zone.now
    count = params[:count] || 5000
    klass.save_numerous_candles(start: start, finish: finish, count: count)
  end

  # startからfinishの期間がすべて休場時間であるか判定
  def self.between_market_holiday?(start, finish)
    return false if market_workday?(start) || market_workday?(finish)

    diff = finish - start
    diff / 1.day <= 2
  end

  # 土曜の06:00から休場、月曜の06:00から開場だが、
  # サマータイムの考慮がめんどいので1時間余裕をもたせる
  def self.market_holiday?(time)
    if time.saturday?
      time.hour > 6
    elsif time.sunday?
      true
    elsif time.monday?
      time.hour < 5
    else
      false
    end
  end

  def self.market_workday?(time)
    !market_holiday?(time)
  end
end
