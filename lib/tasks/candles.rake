module CandleTask
  extend Rake::DSL

  namespace :usd_jpy_candles do
    desc 'USD/JPY 5秒足ローソクの取得タスク'
    task s5: :environment do
      raise 'START_AT と FINISH_AT を指定してください' unless ENV['START_AT'] && ENV['FINISH_AT']

      start = UsdJpyS5Candle.convert_time(ENV['START_AT'])
      finish = UsdJpyS5Candle.convert_time(ENV['FINISH_AT'])
      count = (ENV['COUNT'] || 5000).to_i
      UsdJpyS5Candle.save_numerous_candles(
        start: start,
        finish: finish,
        count: count
      )
    end

    desc 'USD/JPY 1分足ローソクの取得タスク'
    task m1: :environment do
      raise 'START_AT と FINISH_AT を指定してください' unless ENV['START_AT'] && ENV['FINISH_AT']

      start = UsdJpyM1Candle.convert_time(ENV['START_AT'])
      finish = UsdJpyM1Candle.convert_time(ENV['FINISH_AT'])
      count = (ENV['COUNT'] || 5000).to_i
      UsdJpyM1Candle.save_numerous_candles(
        start: start,
        finish: finish,
        count: count
      )
    end
  end
end
