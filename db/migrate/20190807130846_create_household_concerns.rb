class CreateHouseholdConcerns < ActiveRecord::Migration[5.2]
  def change
    create_table :household_concerns do |t|
      t.references :household, foreign_key: true
      t.references :concerns, foreign_key: true
      t.boolean :inactive

      t.timestamps
    end
  end
end
