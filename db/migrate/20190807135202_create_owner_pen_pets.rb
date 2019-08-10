class CreateOwnerPenPets < ActiveRecord::Migration[5.2]
  def change
    create_table :owner_pen_pets do |t|
      t.references :owner, foreign_key: true
      t.references :pen_type, foreign_key: true
      t.references :pet, foreign_key: true
      t.references :rate, foreign_key: true

      t.timestamps
    end
  end
end
