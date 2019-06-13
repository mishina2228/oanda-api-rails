module CandleTask
  extend Rake::DSL

  namespace :usd_jpy_candles do
    desc 'USD/JPY 5秒足ローソクの取得タスク'
    task s5: :environment do
      raise 'START_AT と FINISH_AT を指定してください' unless ENV['START_AT'] && ENV['FINISH_AT']

      start = ENV['START_AT'].to_time
      finish = ENV['FINISH_AT'].to_time
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

      start = ENV['START_AT'].to_time
      finish = ENV['FINISH_AT'].to_time
      count = (ENV['COUNT'] || 5000).to_i
      UsdJpyM1Candle.save_numerous_candles(
        start: start,
        finish: finish,
        count: count
      )
    end
  end

  # TODO: 処理の共通化
  namespace :eur_jpy_candles do
    desc 'EUR/JPY 1分足ローソクの取得タスク'
    task m1: :environment do
      raise 'START_AT と FINISH_AT を指定してください' unless ENV['START_AT'] && ENV['FINISH_AT']

      start = ENV['START_AT'].to_time
      finish = ENV['FINISH_AT'].to_time
      count = (ENV['COUNT'] || 5000).to_i
      EurJpyM1Candle.save_numerous_candles(
        start: start,
        finish: finish,
        count: count
      )
    end
  end

  namespace :gbp_jpy_candles do
    desc 'GBP/JPY 1分足ローソクの取得タスク'
    task m1: :environment do
      raise 'START_AT と FINISH_AT を指定してください' unless ENV['START_AT'] && ENV['FINISH_AT']

      start = ENV['START_AT'].to_time
      finish = ENV['FINISH_AT'].to_time
      count = (ENV['COUNT'] || 5000).to_i
      GbpJpyM1Candle.save_numerous_candles(
        start: start,
        finish: finish,
        count: count
      )
    end
  end
end
