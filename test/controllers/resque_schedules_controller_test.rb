# frozen_string_literal: true

require 'test_helper'

class ResqueSchedulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resque_schedule = resque_schedules(:job1)
  end

  test 'should get index' do
    get resque_schedules_url
    assert_response :success
  end

  test 'should get edit' do
    get edit_resque_schedule_url(@resque_schedule)
    assert_response :success
  end

  test 'should update resque_schedule' do
    patch resque_schedule_url(@resque_schedule), params: {resque_schedule: {enabled: false}}
    assert_redirected_to resque_schedules_url
    assert_not @resque_schedule.reload.enabled?
  end
end
