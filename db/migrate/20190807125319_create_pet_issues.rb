class CreatePetIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_issues do |t|
      t.references :pet, foreign_key: true
      t.references :issues, foreign_key: true
      t.boolean :inactive

      t.timestamps
    end
  end
end
