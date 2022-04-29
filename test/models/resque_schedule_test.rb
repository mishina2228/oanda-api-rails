# frozen_string_literal: true

require 'test_helper'

class ResqueScheduleTest < ActiveSupport::TestCase
  test 'name should not be blank' do
    assert ResqueSchedule.new(valid_params).valid?
    assert ResqueSchedule.new(valid_params.merge(name: nil)).invalid?
  end

  test 'save_and_setting!' do
    schedule = ResqueSchedule.new(valid_params)
    assert schedule.enabled?
    schedule.save_and_setting!
    assert schedule.persisted?

    schedule.enabled = false
    assert_not schedule.enabled?
    schedule.save_and_setting!
    assert schedule.persisted?
  end

  def valid_params
    {
      name: 'test_schedule',
      description: 'test_description',
      cron: '0 0 1 * *',
      class_name: 'TestJobClass',
      queue: 'normal',
      enabled: true
    }
  end
end
