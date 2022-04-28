module CandleTask
  extend Rake::DSL

  module_function

  def arguments
    raise 'Please specify START_AT and FINISH_AT' if ENV['START_AT'].blank? || ENV['FINISH_AT'].blank?

    {
      start: ENV['START_AT'].to_time,
      finish: ENV['FINISH_AT'].to_time,
      count: ENV.fetch('COUNT', 5000).to_i
    }
  end

  namespace :usd_jpy_candles do
    desc 'USD/JPY 5-second candle acquisition task'
    task s5: :environment do
      UsdJpyS5Candle.save_numerous_candles(**arguments)
    end

    desc 'USD/JPY 1-minute candle acquisition task'
    task m1: :environment do
      UsdJpyM1Candle.save_numerous_candles(**arguments)
    end
  end

  namespace :eur_jpy_candles do
    desc 'EUR/JPY 1-minute candle acquisition task'
    task m1: :environment do
      EurJpyM1Candle.save_numerous_candles(**arguments)
    end
  end

  namespace :gbp_jpy_candles do
    desc 'GBP/JPY 1-minute candle acquisition task'
    task m1: :environment do
      GbpJpyM1Candle.save_numerous_candles(**arguments)
    end
  end
end
