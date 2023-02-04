# frozen_string_literal: true

require 'test_helper'

class UsdJpyM1CandleTest < ActiveSupport::TestCase
  test 'attributes should not be blank' do
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

  test 'should be unique at time' do
    candle = UsdJpyM1Candle.new(valid_params)
    assert candle.save

    new_candle = UsdJpyM1Candle.new(valid_params)
    new_candle.time = candle.time
    assert new_candle.invalid?
    assert_not new_candle.save
  end

  test 'new_candle should return an instance of UsdJpyM1Candle' do
    ba = bidask(time: Time.zone.parse('2019-06-12T00:00:00+0000'))
    mp = midpoint(time: Time.zone.parse('2019-06-12T00:00:00+0000'))
    candle = UsdJpyM1Candle.new_candle(ba, mp)
    assert_instance_of UsdJpyM1Candle, candle
  end
end
