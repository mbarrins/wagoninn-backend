class CreateBookingPens < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_pens do |t|
      t.references :booking, foreign_key: true
      t.references :pen_type, foreign_key: true
      t.references :pen, foreign_key: true
      t.references :rate, foreign_key: true

      t.timestamps
    end
  end
end
