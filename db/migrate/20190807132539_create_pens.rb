class CreatePens < ActiveRecord::Migration[5.2]
  def change
    create_table :pens do |t|
      t.references :room_type, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
