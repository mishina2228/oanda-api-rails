# frozen_string_literal: true

class CandleInformationController < ApplicationController
  def index
    @candle_information = CandleInformation.new(
      usd_jpy_m1_count: UsdJpyM1Candle.pseudo_count,
      eur_jpy_m1_count: EurJpyM1Candle.pseudo_count,
      gbp_jpy_m1_count: GbpJpyM1Candle.pseudo_count,
      usd_jpy_m1_latest: UsdJpyM1Candle.latest_candle,
      eur_jpy_m1_latest: EurJpyM1Candle.latest_candle,
      gbp_jpy_m1_latest: GbpJpyM1Candle.latest_candle
    )
  end
end
