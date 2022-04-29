# frozen_string_literal: true

require 'test_helper'

class CandleAccessTest < ActiveSupport::TestCase
  test 'attributes should not be blank' do
    assert CandleAccess.new(valid_params).valid?
    assert CandleAccess.new(valid_params.merge(candle_format: nil)).invalid?
    assert CandleAccess.new(valid_params.merge(candle_format: '')).invalid?
    assert CandleAccess.new(valid_params.merge(granularity: nil)).invalid?
    assert CandleAccess.new(valid_params.merge(granularity: '')).invalid?
    assert CandleAccess.new(valid_params.merge(instrument: nil)).invalid?
    assert CandleAccess.new(valid_params.merge(instrument: '')).invalid?
    assert CandleAccess.new(valid_params.merge(count: nil)).invalid?
    assert CandleAccess.new(valid_params.merge(count: '')).invalid?
    assert CandleAccess.new(valid_params.merge(start: nil)).invalid?
    assert CandleAccess.new(valid_params.merge(start: '')).invalid?
  end

  test 'count should be more than 0 and less than 5001' do
    assert CandleAccess.new(valid_params.merge(count: -1)).invalid?
    assert CandleAccess.new(valid_params.merge(count: 0)).invalid?
    assert CandleAccess.new(valid_params.merge(count: 1)).valid?
    assert CandleAccess.new(valid_params.merge(count: 5000)).valid?
    assert CandleAccess.new(valid_params.merge(count: 5001)).invalid?
  end

  test 'validate format of start' do
    assert CandleAccess.new(valid_params.merge(start: '2018-01-01')).invalid?
    assert CandleAccess.new(valid_params.merge(start: '2018-01-01T00:00:00')).invalid?
    assert CandleAccess.new(valid_params.merge(start: '2018/01/01T00:00:00+00:00')).invalid?
    assert CandleAccess.new(valid_params.merge(start: '2018-01-01 00:00:00+00:00')).invalid?
    assert CandleAccess.new(valid_params.merge(start: '2018-01-01T00:00:00++09:00')).invalid?
    assert CandleAccess.new(valid_params.merge(start: '2018-01-01T00:00:00+09:00')).valid?
    assert CandleAccess.new(valid_params.merge(start: '2018-01-01T00:00:00-10:00')).valid?
    assert CandleAccess.new(valid_params.merge(start: '2018-01-01T00:00:00+00:30')).valid?
    assert CandleAccess.new(valid_params.merge(start: '2018-01-01T00:00:00.000Z')).valid?
  end

  def valid_params
    {
      candle_format: 'bidask',
      granularity: 'M1',
      instrument: 'USD_JPY',
      count: 100,
      start: '2019-07-12T08:00:00+00:00'
    }
  end
end
