class CreateImmunisations < ActiveRecord::Migration[5.2]
  def change
    create_table :immunisations do |t|
      t.references :pet_type, foreign_key: true
      t.string :name
      t.boolean :current, default: true

      t.timestamps
    end
  end
end
