class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :booking_ref
      t.references :household, foreign_key: true
      t.date :check_in
      t.string :check_in_time
      t.date :check_out
      t.string :check_out_time
      t.references :booking_status, foreign_key: true

      t.timestamps
    end
  end
end
