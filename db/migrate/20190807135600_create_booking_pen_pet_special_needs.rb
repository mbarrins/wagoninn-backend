class CreateBookingPenPetSpecialNeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_pen_pet_special_needs do |t|
      t.references :booking_pen_pet, foreign_key: true
      t.references :special_need, foreign_key: true

      t.timestamps
    end
  end
end
