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
        Rails.logger.info('something is wrong!')
        Rails.logger.info(e.inspect)
      end
    else
      @candle_data = {}
    end
    render plain: JSON.pretty_generate(@candle_data)
  end

  private

  def candle_access_params
    attrs = %i(candle_format granularity instrument count start)
    params.fetch(:candle_access, {}).permit(*attrs)
  end

  def default_values
    {
      granularity: 'M1',
      count: 100,
      start: Time.zone.now.to_datetime.rfc3339
    }
  end
end
