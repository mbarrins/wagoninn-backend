class CreateHouseholds < ActiveRecord::Migration[5.2]
  def change
    create_table :households do |t|
      t.boolean :agreed_terms
      t.string :agreed_person_id
      t.date :agreed_date
      t.text :notes

      t.timestamps
    end
  end
end
