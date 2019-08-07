class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :schedule
      t.string :fee

      t.timestamps
    end
  end
end
