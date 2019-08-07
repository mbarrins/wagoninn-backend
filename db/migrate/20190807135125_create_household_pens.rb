class CreateHouseholdPens < ActiveRecord::Migration[5.2]
  def change
    create_table :household_pens do |t|
      t.references :household, foreign_key: true
      t.references :pen_type, foreign_key: true

      t.timestamps
    end
  end
end
