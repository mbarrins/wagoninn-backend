class CreateHouseholdCares < ActiveRecord::Migration[5.2]
  def change
    create_table :household_cares do |t|
      t.references :household, foreign_key: true
      t.references :cares, foreign_key: true
      t.boolean :inactive

      t.timestamps
    end
  end
end
