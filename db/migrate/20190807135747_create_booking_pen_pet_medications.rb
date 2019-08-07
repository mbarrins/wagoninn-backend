class CreateBookingPenPetMedications < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_pen_pet_medications do |t|
      t.references :booking_pen_pet, foreign_key: true
      t.references :medication, foreign_key: true
      t.references :dose, foreign_key: true
      t.integer :dose_quantity
      t.references :schedule, foreign_key: true
      t.decimal :fee

      t.timestamps
    end
  end
end
