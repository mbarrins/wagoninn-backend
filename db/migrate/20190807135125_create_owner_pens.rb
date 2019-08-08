class CreateOwnerPens < ActiveRecord::Migration[5.2]
  def change
    create_table :owner_pens do |t|
      t.references :owner, foreign_key: true
      t.references :pen_type, foreign_key: true

      t.timestamps
    end
  end
end
