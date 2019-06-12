require 'test_helper'

class UsdJpyM1CandleTest < ActiveSupport::TestCase
  def test_validation
    assert UsdJpyM1Candle.new(valid_params).valid?
    assert UsdJpyM1Candle.new(valid_params.merge(close_ask: nil)).invalid?
    assert UsdJpyM1Candle.new(valid_params.merge(close_bid: nil)).invalid?
    assert UsdJpyM1Candle.new(valid_params.merge(close_mid: nil)).invalid?
    assert UsdJpyM1Candle.new(valid_params.merge(high_ask: nil)).invalid?
    assert UsdJpyM1Candle.new(valid_params.merge(high_bid: nil)).invalid?
    assert UsdJpyM1Candle.new(valid_params.merge(high_mid: nil)).invalid?
    assert UsdJpyM1Candle.new(valid_params.merge(low_ask: nil)).invalid?
    assert UsdJpyM1Candle.new(valid_params.merge(low_bid: nil)).invalid?
    assert UsdJpyM1Candle.new(valid_params.merge(low_mid: nil)).invalid?
    assert UsdJpyM1Candle.new(valid_params.merge(open_ask: nil)).invalid?
    assert UsdJpyM1Candle.new(valid_params.merge(open_bid: nil)).invalid?
    assert UsdJpyM1Candle.new(valid_params.merge(open_mid: nil)).invalid?
    assert UsdJpyM1Candle.new(valid_params.merge(time: nil)).invalid?
    assert UsdJpyM1Candle.new(valid_params.merge(volume: nil)).invalid?
  end

  def test_unique_validation
    candle = UsdJpyM1Candle.new(valid_params)
    assert candle.save

    new_candle = UsdJpyM1Candle.new(valid_params)
    new_candle.time = candle.time
    assert new_candle.invalid?
    assert_not new_candle.save
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
