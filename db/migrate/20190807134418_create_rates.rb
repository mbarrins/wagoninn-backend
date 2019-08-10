class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.references :pen_type, foreign_key: true
      t.integer :no
      t.string :desc
      t.decimal :amount
      t.date :effective_from
      t.date :effective_to

      t.timestamps
    end
  end
end
