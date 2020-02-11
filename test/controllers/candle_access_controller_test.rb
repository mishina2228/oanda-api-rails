require 'test_helper'

class CandleAccessControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get candle_access_index_url
    assert_response :success
  end
end
