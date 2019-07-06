class CandleJob
  def self.before_enqueue(params = {})
    params = params.with_indifferent_access
    jobs = Resque.peek(@queue, 0, 100)
    jobs.each do |job|
      next if job['class'] != name

      args = job['args'].first || {}
      if params['start'] == args['start'] && params['finish'] == args['finish'] && params['count'] == args['count']
        return false
      end
    end
    true
  end

  def self.perform(klass, params = {})
    raise 'class must be specified' if klass.blank?
    raise 'class must be some candle-ish' unless klass.include?(CandleConcern)

    params = params.with_indifferent_access
    start, finish, count = arrange_params(klass, params)
    if start >= finish
      Rails.logger.info '開始時刻が終了時刻以前であるため終了します。'
      Rails.logger.info "start: #{start}, finish: #{finish}"
      return
    end

    if between_market_holiday?(start, finish)
      Rails.logger.info '指定期間が全て休場中のため、処理を終了します。'
      Rails.logger.info "start: #{start}, finish: #{finish}"
      return
    end

    ret = klass.gimme_candle(start: start, count: count)
    if ret.present?
      Rails.logger.info "#{ret.last.time} まで取得しました。"
      start = ret.last.time + klass.const_get(:TIME_RANGE)
    else
      start += count * klass.const_get(:TIME_RANGE)
    end

    if start >= finish
      Rails.logger.info "finish: #{finish.in_time_zone('Asia/Tokyo')} を超えたので終了します。"
      return
    end

    Rails.logger.info "次の取得を開始: start = #{start}"
    Resque.enqueue_in_with_queue(
      @queue, 1.minute, self,
      start: start, finish: finish, count: count
    )
  end

  def self.arrange_params(klass, params)
    start = if params[:start]
              params[:start].to_time
            elsif klass.latest_candle
              klass.latest_candle.time + klass::TIME_RANGE
            else
              Time.new(2000, 1, 1, 0, 0, 0, '+09:00')
            end
    finish = if params[:finish]
               params[:finish].to_time
             else
               Time.zone.now
             end
    count = (params[:count] || 5000).to_i
    [start, finish, count]
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
    time = time.in_time_zone('Asia/Tokyo')
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
