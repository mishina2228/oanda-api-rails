class CreateResqueSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :resque_schedules do |t|
      t.string :name, null: false
      t.string :description
      t.string :cron
      t.string :class_name
      t.string :queue
      t.boolean :enabled, null: false, default: false

      t.timestamps null: false
    end
  end
end
