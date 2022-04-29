# frozen_string_literal: true

class CandleAccessController < ApplicationController
  def index
    @candle_access = CandleAccess.new(default_values)
  end

  def access
    candle_access = CandleAccess.new(candle_access_params)
    if candle_access.valid?
      begin
        @candle_data = candle_access.access
      rescue OandaAPI::RequestError => e
        Rails.logger.error('something went wrong!')
        Rails.logger.error(e.inspect)
        raise e
      end
    else
      @candle_data = [{message: 'search parameters are invalid.'}]
    end
    render json: @candle_data
  end

  private

  def candle_access_params
    attrs = [:candle_format, :granularity, :instrument, :count, :start]
    params.fetch(:candle_access, {}).permit(*attrs)
  end

  def default_values
    {
      granularity: 'M1',
      count: 100,
      start: Time.zone.now.rfc3339
    }
  end
end
