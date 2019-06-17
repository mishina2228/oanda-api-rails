require 'test_helper'

class ResqueScheduleTest < ActiveSupport::TestCase
  def test_validation
    assert ResqueSchedule.new(valid_params).valid?
    assert ResqueSchedule.new(valid_params.merge(name: nil)).invalid?
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
