module CandleTask
  extend Rake::DSL

  module_function

  def arguments
    raise 'START_AT と FINISH_AT を指定してください' if ENV['START_AT'].blank? || ENV['FINISH_AT'].blank?

    {
      start: ENV['START_AT'].to_time,
      finish: ENV['FINISH_AT'].to_time,
      count: (ENV['COUNT'] || 5000).to_i
    }
  end

  namespace :usd_jpy_candles do
    desc 'USD/JPY 5秒足ローソクの取得タスク'
    task s5: :environment do
      UsdJpyS5Candle.save_numerous_candles(arguments)
    end

    desc 'USD/JPY 1分足ローソクの取得タスク'
    task m1: :environment do
      UsdJpyM1Candle.save_numerous_candles(arguments)
    end
  end

  namespace :eur_jpy_candles do
    desc 'EUR/JPY 1分足ローソクの取得タスク'
    task m1: :environment do
      EurJpyM1Candle.save_numerous_candles(arguments)
    end
  end

  namespace :gbp_jpy_candles do
    desc 'GBP/JPY 1分足ローソクの取得タスク'
    task m1: :environment do
      GbpJpyM1Candle.save_numerous_candles(arguments)
    end
  end
end
