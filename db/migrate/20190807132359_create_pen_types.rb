class CreatePenTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :pen_types do |t|
      t.references :pet_type, foreign_key: true
      t.string :name
      t.integer :max_per_pen
      t.integer :no_pens
    end
  end
end
