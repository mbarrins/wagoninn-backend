class CreatePetHealthDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_health_details do |t|
      t.references :pet, foreign_key: true
      t.references :health_detail, foreign_key: true
      t.boolean :inactive

      t.timestamps
    end
  end
end
