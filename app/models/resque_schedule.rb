class ResqueSchedule < ApplicationRecord
  validates :name, presence: true

  def save_and_setting!
    save!
    setup_resque_schedule
  end

  def setup_resque_schedule
    if enabled?
      Resque.set_schedule(name, schedule_config)
    else
      Resque.remove_schedule(name)
    end
  end

  def schedule_config
    {
      cron: cron,
      class: class_name,
      queue: queue,
      description: description,
      persist: true
    }
  end
end
