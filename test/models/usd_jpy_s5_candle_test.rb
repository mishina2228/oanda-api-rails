require 'test_helper'

class UsdJpyS5CandleTest < ActiveSupport::TestCase
  def test_validation
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

  def test_unique_validation
    candle = UsdJpyS5Candle.new(valid_params)
    assert candle.save

    new_candle = UsdJpyS5Candle.new(valid_params)
    new_candle.time = candle.time
    assert new_candle.invalid?
    assert_not new_candle.save
  end

  def test_convert_time
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

  def test_import_invalid_candles
    candle = UsdJpyS5Candle.new(valid_params)
    dup_candle = UsdJpyS5Candle.new(valid_params)
    dup_candle.time = candle.time

    assert_raise ActiveRecord::RecordNotUnique do
      UsdJpyS5Candle.import!([candle, dup_candle])
    end
  end

  def test_merge_into_indifferent_size
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
    assert_equal 2, ret.size, '数がbidaskとmidpointで一致しないときは、timeが一致しないものを飛ばすこと'
    ng = %w(2019-06-12T00:00:10+0000)
    ret.each do |candle|
      assert_not ng.include?(candle.time.strftime('%Y-%m-%dT%H:%M:%S%z')), '一致しないデータが入っていないこと'
    end
  end

  def test_merge_into_time_mismatch
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
    assert_equal 2, ret.size, 'timeがbidaskとmidpointで一致しないときはそれを飛ばすこと'
    ng = %w(2019-06-12T00:00:10+0000 2019-06-12T00:00:15+0000)
    ret.each do |candle|
      assert_not ng.include?(candle.time.strftime('%Y-%m-%dT%H:%M:%S%z')), '一致しないデータが入っていないこと'
    end
  end

  def test_merge_into_not_complete
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
    assert_equal 2, ret.size, 'completeでないデータは飛ばすこと'
    ng = %w(2019-06-12T00:00:10+0000)
    ret.each do |candle|
      assert_not ng.include?(candle.time.strftime('%Y-%m-%dT%H:%M:%S%z')), 'completeでないデータが入っていないこと'
    end
  end

  def test_merge_into_duplicate_time
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
    assert_equal 2, ret.size, '重複しているデータは飛ばすこと'
  end

  def test_merge_into_unique_time
    assert UsdJpyS5Candle.create(valid_params.merge(time: Time.zone.parse('2019-06-12T00:00:00+0000')))

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
    assert_equal 2, ret.size, 'DBに登録済みのデータは飛ばすこと'
    ng = %w(2019-06-12T00:00:10+0000)
    ret.each do |candle|
      assert_not ng.include?(candle.time.strftime('%Y-%m-%dT%H:%M:%S%z')), 'DBに登録済みのデータが入っていないこと'
    end
  end

  def test_new_candle
    ba = bidask(time: Time.zone.parse('2019-06-12T00:00:00+0000'))
    mp = midpoint(time: Time.zone.parse('2019-06-12T00:00:00+0000'))
    candle = UsdJpyS5Candle.new_candle(ba, mp)
    assert candle.is_a?(UsdJpyS5Candle)
  end

  def valid_params
    {
      close_ask: 108.550,
      close_bid: 108.550,
      close_mid: 108.550,
      high_ask: 108.550,
      high_bid: 108.550,
      high_mid: 108.550,
      low_ask: 108.550,
      low_bid: 108.550,
      low_mid: 108.550,
      open_ask: 108.550,
      open_bid: 108.550,
      open_mid: 108.550,
      time: Time.zone.parse('2019-06-12T00:00:00+0900'),
      volume: 1
    }
  end
end
