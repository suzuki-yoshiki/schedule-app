class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
