require 'test_helper'

class CandleJobTest < ActiveSupport::TestCase
  def test_between_market_holiday?
    start = Time.new(2019, 6, 15, 7, 0, 0).in_time_zone('Asia/Tokyo')
    assert CandleJob.market_holiday?(start)
    finish = Time.new(2019, 6, 17, 4, 59, 0).in_time_zone('Asia/Tokyo')
    assert CandleJob.market_holiday?(finish)
    # start,finishが共に休場時間で、期間が2日以内ならその期間は休場
    assert CandleJob.between_market_holiday?(start, finish)

    start = Time.new(2019, 6, 15, 7, 0, 0).in_time_zone('Asia/Tokyo')
    assert CandleJob.market_holiday?(start)
    finish = Time.new(2019, 6, 17, 5, 0, 0).in_time_zone('Asia/Tokyo')
    assert_not CandleJob.market_holiday?(finish)
    # start,finishのいずれかが開場時間ならその期間は開場
    assert_not CandleJob.between_market_holiday?(start, finish)

    start = Time.new(2019, 6, 15, 6, 59, 0).in_time_zone('Asia/Tokyo')
    assert_not CandleJob.market_holiday?(start)
    finish = Time.new(2019, 6, 17, 4, 59, 0).in_time_zone('Asia/Tokyo')
    assert CandleJob.market_holiday?(finish)
    # start,finishのいずれかが開場時間ならその期間は開場
    assert_not CandleJob.between_market_holiday?(start, finish)

    start = Time.new(2019, 6, 15, 6, 59, 0).in_time_zone('Asia/Tokyo')
    assert_not CandleJob.market_holiday?(start)
    finish = Time.new(2019, 6, 17, 5, 0, 0).in_time_zone('Asia/Tokyo')
    assert_not CandleJob.market_holiday?(finish)
    # start,finishのいずれかが開場時間ならその期間は開場
    assert_not CandleJob.between_market_holiday?(start, finish)

    start = Time.new(2019, 6, 15, 7, 0, 0).in_time_zone('Asia/Tokyo')
    assert CandleJob.market_holiday?(start)
    finish = Time.new(2019, 6, 22, 7, 0, 0).in_time_zone('Asia/Tokyo')
    assert CandleJob.market_holiday?(finish)
    # start,finishが共に休場時間でも、期間が2日以上あればその期間は開場時間を含むので開場
    assert_not CandleJob.between_market_holiday?(start, finish)
  end

  def test_market_holiday?
    sunday = Time.new(2019, 6, 16).in_time_zone('Asia/Tokyo')
    assert sunday.sunday?
    assert CandleJob.market_holiday?(sunday)

    saturday = Time.new(2019, 6, 15, 6, 59, 0).in_time_zone('Asia/Tokyo')
    assert saturday.saturday?
    assert_not CandleJob.market_holiday?(saturday), '土曜の6:59までは開場とする'
    saturday = Time.new(2019, 6, 15, 7, 0, 0).in_time_zone('Asia/Tokyo')
    assert saturday.saturday?
    assert CandleJob.market_holiday?(saturday), '土曜の7:00以降は休場とする'

    monday = Time.new(2019, 6, 17, 4, 59, 0).in_time_zone('Asia/Tokyo')
    assert monday.monday?
    assert CandleJob.market_holiday?(monday), '月曜の4:59までは休場とする'
    monday = Time.new(2019, 6, 17, 5, 0, 0).in_time_zone('Asia/Tokyo')
    assert monday.monday?
    assert_not CandleJob.market_holiday?(monday), '月曜の5:00からは開場とする'
  end
end
