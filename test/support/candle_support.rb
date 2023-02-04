# frozen_string_literal: true

module CandleSupport
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
