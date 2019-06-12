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

  def test_new_candle
    ba = bidask(time: Time.zone.parse('2019-06-12T00:00:00+0000'))
    mp = midpoint(time: Time.zone.parse('2019-06-12T00:00:00+0000'))
    candle = UsdJpyM1Candle.new_candle(ba, mp)
    assert candle.is_a?(UsdJpyM1Candle)
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

  # TODO: 共通化処理
  def bidask(params = {})
    time = params[:time] || Time.zone.parse('2019-06-12T00:00:00+0000')
    time = time.utc
    OandaAPI::Resource::Candle.new(
      close_ask: params[:close_ask] || 108.550,
      close_bid: params[:close_bid] || 108.550,
      high_ask: params[:high_ask] || 108.550,
      high_bid: params[:high_bid] || 108.550,
      low_ask: params[:low_ask] || 108.550,
      low_bid: params[:low_bid] || 108.550,
      open_ask: params[:open_ask] || 108.550,
      open_bid: params[:open_bid] || 108.550,
      time: time,
      volume: params[:volume] || 1,
      complete: params[:complete].nil? ? true : params[:complete]
    )
  end

  def midpoint(params = {})
    time = params[:time] || Time.zone.parse('2019-06-12T00:00:00+0000')
    time = time.utc
    OandaAPI::Resource::Candle.new(
      close_mid: params[:close_mid] || 108.550,
      high_mid: params[:high_mid] || 108.550,
      low_mid: params[:low_mid] || 108.550,
      open_mid: params[:open_mid] || 108.550,
      time: time,
      volume: params[:volume] || 1,
      complete: params[:complete] || true
    )
  end
end
