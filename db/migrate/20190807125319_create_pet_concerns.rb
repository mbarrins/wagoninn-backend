class CreatePetConcerns < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_concerns do |t|
      t.references :pet, foreign_key: true
      t.references :concerns, foreign_key: true
      t.boolean :inactive

      t.timestamps
    end
  end
end
