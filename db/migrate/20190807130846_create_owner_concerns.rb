class CreateOwnerConcerns < ActiveRecord::Migration[5.2]
  def change
    create_table :owner_concerns do |t|
      t.references :owner, foreign_key: true
      t.references :concerns, foreign_key: true
      t.boolean :inactive

      t.timestamps
    end
  end
end
