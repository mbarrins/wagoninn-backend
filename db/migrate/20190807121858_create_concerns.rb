class CreateConcerns < ActiveRecord::Migration[5.2]
  def change
    create_table :concerns do |t|
      t.string :concern
      t.boolean :alert

      t.timestamps
    end
  end
end
