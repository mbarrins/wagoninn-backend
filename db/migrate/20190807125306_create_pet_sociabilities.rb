class CreatePetSociabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_sociabilities do |t|
      t.references :pet, foreign_key: true
      t.references :sociability, foreign_key: true
      t.boolean :inactive

      t.timestamps
    end
  end
end
