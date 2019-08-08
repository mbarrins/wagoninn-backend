class CreatePenTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :pen_types do |t|
      t.references :pet_type, foreign_key: true
      t.string :pen_type
    end
  end
end
