class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.references :owner, foreign_key: true
      t.references :pet_type, foreign_key: true
      t.string :name
      t.date :dob
      t.references :sex, foreign_key: true
      t.references :color, foreign_key: true
      t.references :size, foreign_key: true
      t.references :breed, foreign_key: true
      t.boolean :spayed_neutered
      t.text :notes
      t.boolean :special_needs_fee
      t.boolean :no_return
      t.boolean :inactive

      t.timestamps
    end
  end
end
