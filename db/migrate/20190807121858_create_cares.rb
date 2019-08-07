class CreateCares < ActiveRecord::Migration[5.2]
  def change
    create_table :cares do |t|
      t.string :care
      t.boolean :alert

      t.timestamps
    end
  end
end
