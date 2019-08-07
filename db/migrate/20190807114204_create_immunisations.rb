class CreateImmunisations < ActiveRecord::Migration[5.2]
  def change
    create_table :immunisations do |t|
      t.string :immunisation

      t.timestamps
    end
  end
end
