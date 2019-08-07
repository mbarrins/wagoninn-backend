class CreatePhones < ActiveRecord::Migration[5.2]
  def change
    create_table :phones do |t|
      t.references :phone_type, foreign_key: true
      t.references :person, foreign_key: true
      t.string :number
      t.string :extension
      t.date :effective_from
      t.date :effective_to

      t.timestamps
    end
  end
end
