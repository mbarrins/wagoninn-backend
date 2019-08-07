class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :household, foreign_key: true
      t.string :line_1
      t.string :line_2
      t.string :line_3
      t.string :city
      t.string :state
      t.string :zip
      t.date :effective_from
      t.date :effective_to

      t.timestamps
    end
  end
end
