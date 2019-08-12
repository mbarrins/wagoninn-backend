class CreatePens < ActiveRecord::Migration[5.2]
  def change
    create_table :pens do |t|
      t.references :pen_type, foreign_key: true
      t.integer :no
      t.string :name

      t.timestamps
    end
  end
end
