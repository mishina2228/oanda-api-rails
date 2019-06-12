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

    error = assert_raises ArgumentError do
      UsdJpyS5Candle.convert_time(123)
    end
    regexp = /type: #{123.class}\z/
    assert_match regexp, error.message
  end

  def valid_params
    {
      close_ask: 108.50,
      close_bid: 108.50,
      close_mid: 108.50,
      high_ask: 108.50,
      high_bid: 108.50,
      high_mid: 108.50,
      low_ask: 108.50,
      low_bid: 108.50,
      low_mid: 108.50,
      open_ask: 108.50,
      open_bid: 108.50,
      open_mid: 108.50,
      time: Time.zone.parse('2019-06-12T00:00:00+0900'),
      volume: 1
    }
  end
end
