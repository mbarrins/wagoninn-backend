class CreatePetSpecialNeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_special_needs do |t|
      t.references :pet, foreign_key: true
      t.references :special_need, foreign_key: true
      t.date :effective_from
      t.date :effective_to

      t.timestamps
    end
  end
end
