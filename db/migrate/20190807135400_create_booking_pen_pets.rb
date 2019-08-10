class CreateBookingPenPets < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_pen_pets do |t|
      t.references :booking, foreign_key: true
      t.references :pen_type, foreign_key: true
      t.references :pen, foreign_key: true
      t.references :pet, foreign_key: true
      t.references :rate, foreign_key: true
      t.boolean :special_needs_fee

      t.timestamps
    end
  end
end
