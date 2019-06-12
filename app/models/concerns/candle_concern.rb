module CandleConcern
  extend ActiveSupport::Concern

  included do
    validates :time, presence: true, uniqueness: true

    validates :close_ask, presence: true
    validates :close_bid, presence: true
    validates :close_mid, presence: true
    validates :high_ask, presence: true
    validates :high_bid, presence: true
    validates :high_mid, presence: true
    validates :low_ask, presence: true
    validates :low_bid, presence: true
    validates :low_mid, presence: true
    validates :open_ask, presence: true
    validates :open_bid, presence: true
    validates :open_mid, presence: true
    validates :volume, presence: true
  end

  module ClassMethods
    # Usage:
    # UsdJpyS5Candle.save_numerous_candles(start: Time.parse('2002/02/06 00:00:00+0000'),
    #                       finish: Time.parse('2002/10/06 00:00:00+0000'),
    #                       count: 100)
    # start: Time
    # finish: Time
    # count: Integer
    def save_numerous_candles(start:, finish:, count:)
      loop do
        if start >= finish
          puts "finish: #{finish.in_time_zone('Asia/Tokyo')} を超えたので終了します。"
          break
        end
        ret = gimme_candle(start: start, count: count)
        if ret.present?
          puts "#{ret.last.time} まで取得しました。"
          start = ret.last.time + const_get(:TIME_RANGE)
        else
          start += count * const_get(:TIME_RANGE)
        end
        puts "次の取得を開始: start = #{start}"
      end
    end

    # start: String, Time, nil
    # count: Integer
    def gimme_candle(start:, count:)
      start = convert_time(start)
      count ||= 100
      unless count.between?(1, 5000)
        message = 'The value specified is not in the valid range: ' \
                  "The [count]= #{count} specified is not within the valid range. " \
                  'Valid range is between 1 and 5000'
        raise message
      end

      params = {
        instrument: 'USD_JPY',
        granularity: const_get(:GRANULARITY),
        count: count,
        start: start
      }
      puts "params: #{params}"
      client = Mishina::Oanda::Client.client
      bidask_data = client.candles(
        params.merge(candle_format: OandaAPI::Resource::Candle::Format::BIDASK)
      ).get
      midpoint_data = client.candles(
        params.merge(candle_format: OandaAPI::Resource::Candle::Format::MIDPOINT)
      ).get
      puts 'データ取得完了 & データ整形開始'

      bidasks = bidask_data.instance_variable_get(:@collection)
      midpoints = midpoint_data.instance_variable_get(:@collection)

      candles = merge_into(bidasks, midpoints)
      puts 'データ整形終了 & バルクインサート開始'
      # DBに制約があるので import でも import! でも落ちるのだ
      import!(candles)
      puts 'バルクインサート終了'
      candles
    end

    def convert_time(start = nil)
      start_date = if start.is_a?(Time)
                     start
                   elsif start.is_a?(String)
                     Time.zone.parse(start)
                   elsif start.nil?
                     Time.zone.now
                   else
                     raise ArgumentError, "wrong argument type: #{start.class}"
                   end
      start_date.utc.to_datetime.rfc3339
    end

    def merge_into(bidasks, midpoints)
      if bidasks.size != midpoints.size
        raise "number does not match. bidask: #{bidasks.size}, midpoint: #{midpoints.size}"
      end

      candles = bidasks.map do |bidask|
        midpoint = midpoints.find {|mid| mid.time == bidask.time}
        unless midpoint
          puts "bidaskとmidpointでtimeが一致しないデータをスキップします。 time: #{bidask.time}"
          next
        end
        next unless bidask.complete? && midpoint.complete? # どっちかがcompleteじゃなければskip

        candle = new_candle(bidask, midpoint)
        # すでに登録済のレコードをスキップ
        if candle.invalid?
          puts "time: #{candle.time} のレコードがすでに存在するため、スキップします。"
          next
        end

        candle
      end
      candles.compact.uniq(&:time)
    end

    def new_candle(bidask, midpoint)
      candle = new

      candle.open_bid = bidask.open_bid
      candle.close_bid = bidask.close_bid
      candle.high_bid = bidask.high_bid
      candle.low_bid = bidask.low_bid
      candle.open_ask = bidask.open_ask
      candle.close_ask = bidask.close_ask
      candle.high_ask = bidask.high_ask
      candle.low_ask = bidask.low_ask

      candle.open_mid = midpoint.open_mid
      candle.close_mid = midpoint.close_mid
      candle.high_mid = midpoint.high_mid
      candle.low_mid = midpoint.low_mid

      candle.time = bidask.time.in_time_zone('Asia/Tokyo') # 日本時間に変換
      candle.volume = bidask.volume # midpointの値と同じ

      candle
    end
  end
end