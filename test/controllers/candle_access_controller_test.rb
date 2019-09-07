require 'test_helper'

class CandleAccessControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get candle_information_index_url
    assert_response :success
  end
end
