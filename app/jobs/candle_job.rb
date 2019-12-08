class CandleJob
  def self.before_enqueue(params = {})
    params = params.with_indifferent_access
    jobs = JobUtils.peek(@queue, 0, 100)
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
    raise 'Class must be specified.' if klass.blank?
    raise 'Class must be some candle-ish.' unless klass.include?(CandleConcern)

    params = params.with_indifferent_access
    start, finish, count = arrange_params(klass, params)
    if start >= finish
      Rails.logger.info 'Finish the process because the start time is before the end time.'
      Rails.logger.info "start: #{start}, finish: #{finish}"
      return
    end

    if between_market_holiday?(start, finish)
      Rails.logger.info 'Finish the process because all specified period is in the closed period.'
      Rails.logger.info "start: #{start}, finish: #{finish}"
      return
    end

    ret = klass.gimme_candle(start: start, count: count)
    if ret.present?
      Rails.logger.info "Acquired until #{ret.last.time}."
      start = ret.last.time + klass.const_get(:TIME_RANGE)
    else
      start += count * klass.const_get(:TIME_RANGE)
    end

    if start >= finish
      Rails.logger.info "Exceeded finish: #{finish.in_time_zone('Asia/Tokyo')}. Finish the process."
      return
    end

    Rails.logger.info "Start next acquisition. start: #{start}"
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

  # Determine whether period from start to finish is in the closed period.
  def self.between_market_holiday?(start, finish)
    return false if market_workday?(start) || market_workday?(finish)

    diff = finish - start
    diff / 1.day <= 2
  end

  # Closed from 06:00 on Saturday. Open from 06:00 on Monday.
  # Extend by one hour since it is difficult to consider daylight saving time.
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
