class CreateImmunisations < ActiveRecord::Migration[5.2]
  def change
    create_table :immunisations do |t|
      t.string :immunisation
 
    end
  end
end
