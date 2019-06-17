# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ResqueSchedule.create(
  name: 'usd_jpy_m1_candle_job',
  cron: '*/10 * * * 1-6',
  class_name: 'UsdJpyM1CandleJob',
  queue: 'normal',
  description: 'USD/JPY の1分足ローソク取得ジョブ'
)
ResqueSchedule.create(
  name: 'eur_jpy_m1_candle_job',
  cron: '*/10 * * * 1-6',
  class_name: 'EurJpyM1CandleJob',
  queue: 'normal',
  description: 'EUR/JPY の1分足ローソク取得ジョブ'
)
ResqueSchedule.create(
  name: 'gbp_jpy_m1_candle_job',
  cron: '*/10 * * * 1-6',
  class_name: 'GbpJpyM1CandleJob',
  queue: 'normal',
  description: 'GBP/JPY の1分足ローソク取得ジョブ'
)
