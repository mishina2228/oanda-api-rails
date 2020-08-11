require 'test_helper'

class CandleJobTest < ActiveSupport::TestCase
  test 'between_market_holiday?' do
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

  test 'market_holiday? from Saturday to Monday' do
    sunday = Time.new(2019, 6, 16).in_time_zone('Asia/Tokyo')
    assert sunday.sunday?
    assert CandleJob.market_holiday?(sunday)

    saturday = Time.new(2019, 6, 15, 6, 59, 0).in_time_zone('Asia/Tokyo')
    assert saturday.saturday?
    assert_not CandleJob.market_holiday?(saturday), 'open until 6:59 on Saturday in JST'
    saturday = Time.new(2019, 6, 15, 7, 0, 0).in_time_zone('Asia/Tokyo')
    assert saturday.saturday?
    assert CandleJob.market_holiday?(saturday), 'closed after 7:00 on Saturday in JST'

    monday = Time.new(2019, 6, 17, 4, 59, 0).in_time_zone('Asia/Tokyo')
    assert monday.monday?
    assert CandleJob.market_holiday?(monday), 'closed until 4:59 on Monday in JST'
    monday = Time.new(2019, 6, 17, 5, 0, 0).in_time_zone('Asia/Tokyo')
    assert monday.monday?
    assert_not CandleJob.market_holiday?(monday), 'open from 5:00 on Monday in JST'
  end

  test 'market_holiday? from Tuesday to Friday' do
    day = Time.new(2019, 6, 18, 5, 0, 0).in_time_zone('Asia/Tokyo')
    assert day.tuesday?
    assert_not CandleJob.market_holiday?(day), 'open all day from Tuesday to Friday'
    day = day.tomorrow
    assert day.wednesday?
    assert_not CandleJob.market_holiday?(day), 'open all day from Tuesday to Friday'
    day = day.tomorrow
    assert day.thursday?
    assert_not CandleJob.market_holiday?(day), 'open all day from Tuesday to Friday'
    day = day.tomorrow
    assert day.friday?
    assert_not CandleJob.market_holiday?(day), 'open all day from Tuesday to Friday'
  end

  test 'between_market_holiday? in UTC' do
    start = Time.new(2019, 6, 15, 7, 0, 0).in_time_zone('Asia/Tokyo').in_time_zone('UTC')
    assert CandleJob.market_holiday?(start)
    finish = Time.new(2019, 6, 17, 4, 59, 0).in_time_zone('Asia/Tokyo').in_time_zone('UTC')
    assert CandleJob.market_holiday?(finish)
    # start,finishが共に休場時間で、期間が2日以内ならその期間は休場
    assert CandleJob.between_market_holiday?(start, finish)

    start = Time.new(2019, 6, 15, 7, 0, 0).in_time_zone('Asia/Tokyo').in_time_zone('UTC')
    assert CandleJob.market_holiday?(start)
    finish = Time.new(2019, 6, 17, 5, 0, 0).in_time_zone('Asia/Tokyo').in_time_zone('UTC')
    assert_not CandleJob.market_holiday?(finish)
    # start,finishのいずれかが開場時間ならその期間は開場
    assert_not CandleJob.between_market_holiday?(start, finish)

    start = Time.new(2019, 6, 15, 6, 59, 0).in_time_zone('Asia/Tokyo').in_time_zone('UTC')
    assert_not CandleJob.market_holiday?(start)
    finish = Time.new(2019, 6, 17, 4, 59, 0).in_time_zone('Asia/Tokyo').in_time_zone('UTC')
    assert CandleJob.market_holiday?(finish)
    # start,finishのいずれかが開場時間ならその期間は開場
    assert_not CandleJob.between_market_holiday?(start, finish)

    start = Time.new(2019, 6, 15, 6, 59, 0).in_time_zone('Asia/Tokyo').in_time_zone('UTC')
    assert_not CandleJob.market_holiday?(start)
    finish = Time.new(2019, 6, 17, 5, 0, 0).in_time_zone('Asia/Tokyo').in_time_zone('UTC')
    assert_not CandleJob.market_holiday?(finish)
    # start,finishのいずれかが開場時間ならその期間は開場
    assert_not CandleJob.between_market_holiday?(start, finish)

    start = Time.new(2019, 6, 15, 7, 0, 0).in_time_zone('Asia/Tokyo').in_time_zone('UTC')
    assert CandleJob.market_holiday?(start)
    finish = Time.new(2019, 6, 22, 7, 0, 0).in_time_zone('Asia/Tokyo').in_time_zone('UTC')
    assert CandleJob.market_holiday?(finish)
    # start,finishが共に休場時間でも、期間が2日以上あればその期間は開場時間を含むので開場
    assert_not CandleJob.between_market_holiday?(start, finish)
  end

  test 'market_holiday? in UTC' do
    sunday = Time.new(2019, 7, 7).in_time_zone('UTC')
    assert CandleJob.market_holiday?(sunday), '日本時間での日曜日であれば休場とする'

    saturday = Time.new(2019, 6, 15, 6, 59, 0).in_time_zone('Asia/Tokyo').in_time_zone('UTC')
    assert_not CandleJob.market_holiday?(saturday), '日本時間での土曜の6:59までは開場とする'
    saturday = Time.new(2019, 6, 15, 7, 0, 0).in_time_zone('Asia/Tokyo').in_time_zone('UTC')
    assert CandleJob.market_holiday?(saturday), '日本時間での土曜の7:00以降は休場とする'

    monday = Time.new(2019, 6, 17, 4, 59, 0).in_time_zone('Asia/Tokyo').in_time_zone('UTC')
    assert CandleJob.market_holiday?(monday), '日本時間での月曜の4:59までは休場とする'
    monday = Time.new(2019, 6, 17, 5, 0, 0).in_time_zone('Asia/Tokyo').in_time_zone('UTC')
    assert_not CandleJob.market_holiday?(monday), '日本時間での月曜の5:00からは開場とする'
  end
end
