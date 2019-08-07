class CreatePetHealthDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_health_details do |t|
      t.references :pet, foreign_key: true
      t.references :health_detail, foreign_key: true
      t.date :effective_from
      t.date :effective_to

      t.timestamps
    end
  end
end
