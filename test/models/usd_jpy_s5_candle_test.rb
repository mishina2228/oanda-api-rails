require 'test_helper'

class UsdJpyS5CandleTest < ActiveSupport::TestCase
  test 'attributes should not be blank' do
    assert UsdJpyS5Candle.new(valid_params).valid?
    assert UsdJpyS5Candle.new(valid_params.merge(close_ask: nil)).invalid?
    assert UsdJpyS5Candle.new(valid_params.merge(close_bid: nil)).invalid?
    assert UsdJpyS5Candle.new(valid_params.merge(close_mid: nil)).invalid?
    assert UsdJpyS5Candle.new(valid_params.merge(high_ask: nil)).invalid?
    assert UsdJpyS5Candle.new(valid_params.merge(high_bid: nil)).invalid?
    assert UsdJpyS5Candle.new(valid_params.merge(high_mid: nil)).invalid?
    assert UsdJpyS5Candle.new(valid_params.merge(low_ask: nil)).invalid?
    assert UsdJpyS5Candle.new(valid_params.merge(low_bid: nil)).invalid?
    assert UsdJpyS5Candle.new(valid_params.merge(low_mid: nil)).invalid?
    assert UsdJpyS5Candle.new(valid_params.merge(open_ask: nil)).invalid?
    assert UsdJpyS5Candle.new(valid_params.merge(open_bid: nil)).invalid?
    assert UsdJpyS5Candle.new(valid_params.merge(open_mid: nil)).invalid?
    assert UsdJpyS5Candle.new(valid_params.merge(time: nil)).invalid?
    assert UsdJpyS5Candle.new(valid_params.merge(volume: nil)).invalid?
  end

  test 'should be unique at time' do
    candle = UsdJpyS5Candle.new(valid_params)
    assert candle.save

    new_candle = UsdJpyS5Candle.new(valid_params)
    new_candle.time = candle.time
    assert new_candle.invalid?
    assert_not new_candle.save
  end

  test 'convert_time' do
    time = Time.zone.parse('2019-06-12T00:00:00+0900')
    ret = UsdJpyS5Candle.convert_time(time)
    assert_equal '2019-06-11T15:00:00+00:00', ret

    time_str = '2019-06-12T00:00:00+0900'
    ret = UsdJpyS5Candle.convert_time(time_str)
    assert_equal '2019-06-11T15:00:00+00:00', ret

    assert_nothing_raised do
      ret = UsdJpyS5Candle.convert_time
      regexp = /\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\+00:00/
      assert_match regexp, ret
    end

    error = assert_raise ArgumentError do
      UsdJpyS5Candle.convert_time(123)
    end
    regexp = /type: #{123.class}\z/
    assert_match regexp, error.message
  end

  test 'cannot import invalid candles' do
    candle = UsdJpyS5Candle.new(valid_params)
    dup_candle = UsdJpyS5Candle.new(valid_params)
    dup_candle.time = candle.time

    assert_raise ActiveRecord::RecordNotUnique do
      UsdJpyS5Candle.import!([candle, dup_candle])
    end
  end

  test 'do not merge unless bidask and mindpoint at the same time' do
    bidasks = [
      bidask(time: Time.zone.parse('2019-06-12T00:00:00+0000')),
      bidask(time: Time.zone.parse('2019-06-12T00:00:05+0000')),
      bidask(time: Time.zone.parse('2019-06-12T00:00:10+0000'))
    ]
    midpoints = [
      midpoint(time: Time.zone.parse('2019-06-12T00:00:00+0000')),
      midpoint(time: Time.zone.parse('2019-06-12T00:00:05+0000'))
    ]

    ret = UsdJpyS5Candle.merge_into(bidasks, midpoints)
    assert_equal 2, ret.size, 'skip it if time does not match in bidask and midpoint'
    ng = %w(2019-06-12T00:00:10+0000)
    ret.each do |candle|
      candle_time = candle.time.strftime('%Y-%m-%dT%H:%M:%S%z')
      assert_not ng.include?(candle_time), 'should not contain unmatched data'
    end
  end

  test 'do not merge unless bidask and mindpoint at the same time 2' do
    bidasks = [
      bidask(time: Time.zone.parse('2019-06-12T00:00:00+0000')),
      bidask(time: Time.zone.parse('2019-06-12T00:00:05+0000')),
      bidask(time: Time.zone.parse('2019-06-12T00:00:10+0000'))
    ]
    midpoints = [
      midpoint(time: Time.zone.parse('2019-06-12T00:00:00+0000')),
      midpoint(time: Time.zone.parse('2019-06-12T00:00:05+0000')),
      midpoint(time: Time.zone.parse('2019-06-12T00:00:15+0000'))
    ]
    ret = UsdJpyS5Candle.merge_into(bidasks, midpoints)
    assert_equal 2, ret.size, 'skip it if time does not match in bidask and midpoint'
    ng = %w(2019-06-12T00:00:10+0000 2019-06-12T00:00:15+0000)
    ret.each do |candle|
      candle_time = candle.time.strftime('%Y-%m-%dT%H:%M:%S%z')
      assert_not ng.include?(candle_time), 'should not contain unmatched data'
    end
  end

  test 'do not merge incomplete candle' do
    bidasks = [
      bidask(time: Time.zone.parse('2019-06-12T00:00:00+0000')),
      bidask(time: Time.zone.parse('2019-06-12T00:00:05+0000')),
      bidask(time: Time.zone.parse('2019-06-12T00:00:10+0000'), complete: false)
    ]
    midpoints = [
      midpoint(time: Time.zone.parse('2019-06-12T00:00:00+0000')),
      midpoint(time: Time.zone.parse('2019-06-12T00:00:05+0000')),
      midpoint(time: Time.zone.parse('2019-06-12T00:00:10+0000'))
    ]
    ret = UsdJpyS5Candle.merge_into(bidasks, midpoints)
    assert_equal 2, ret.size, 'skip it if not complete'
    ng = %w(2019-06-12T00:00:10+0000)
    ret.each do |candle|
      candle_time = candle.time.strftime('%Y-%m-%dT%H:%M:%S%z')
      assert_not ng.include?(candle_time), 'should not contain data that is not complete'
    end
  end

  test 'do not merge duplicate candle' do
    bidasks = [
      bidask(time: Time.zone.parse('2019-06-12T00:00:00+0000')),
      bidask(time: Time.zone.parse('2019-06-12T00:00:05+0000')),
      bidask(time: Time.zone.parse('2019-06-12T00:00:05+0000'))
    ]
    midpoints = [
      midpoint(time: Time.zone.parse('2019-06-12T00:00:00+0000')),
      midpoint(time: Time.zone.parse('2019-06-12T00:00:05+0000')),
      midpoint(time: Time.zone.parse('2019-06-12T00:00:05+0000'))
    ]
    ret = UsdJpyS5Candle.merge_into(bidasks, midpoints)
    assert_equal 2, ret.size, 'skip duplicate data'
  end

  test 'do not merge candle that already exist' do
    assert UsdJpyS5Candle.create(
      valid_params.merge(time: Time.zone.parse('2019-06-12T00:00:00+0000'))
    )

    bidasks = [
      bidask(time: Time.zone.parse('2019-06-12T00:00:00+0000')),
      bidask(time: Time.zone.parse('2019-06-12T00:00:05+0000')),
      bidask(time: Time.zone.parse('2019-06-12T00:00:10+0000'))
    ]
    midpoints = [
      midpoint(time: Time.zone.parse('2019-06-12T00:00:00+0000')),
      midpoint(time: Time.zone.parse('2019-06-12T00:00:05+0000')),
      midpoint(time: Time.zone.parse('2019-06-12T00:00:10+0000'))
    ]
    ret = UsdJpyS5Candle.merge_into(bidasks, midpoints)
    assert_equal 2, ret.size, 'skip registered data'
    ng = %w(2019-06-12T00:00:10+0000)
    ret.each do |candle|
      candle_time = candle.time.strftime('%Y-%m-%dT%H:%M:%S%z')
      assert_not ng.include?(candle_time), 'should not contain registered data'
    end
  end

  test 'new_candle should return an instance of UsdJpyS5Candle' do
    ba = bidask(time: Time.zone.parse('2019-06-12T00:00:00+0000'))
    mp = midpoint(time: Time.zone.parse('2019-06-12T00:00:00+0000'))
    candle = UsdJpyS5Candle.new_candle(ba, mp)
    assert candle.is_a?(UsdJpyS5Candle)
  end
end
