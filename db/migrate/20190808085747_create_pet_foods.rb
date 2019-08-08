class CreatePetFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_foods do |t|
      t.references :pet, foreign_key: true
      t.references :food, foreign_key: true
      t.integer :quantity
      t.references :measure, foreign_key: true
      t.references :schedule, foreign_key: true

      t.timestamps
    end
  end
end
