require 'test_helper'

class ResqueScheduleTest < ActiveSupport::TestCase
  def test_validation
    assert ResqueSchedule.new(valid_params).valid?
    assert ResqueSchedule.new(valid_params.merge(name: nil)).invalid?
  end

  def test_save_and_setting!
    schedule = ResqueSchedule.new(valid_params)
    assert schedule.enabled?
    assert_nothing_raised do
      schedule.save_and_setting!
      assert schedule.persisted?
    end

    schedule.enabled = false
    assert_not schedule.enabled?
    assert_nothing_raised do
      schedule.save_and_setting!
      assert schedule.persisted?
    end
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
