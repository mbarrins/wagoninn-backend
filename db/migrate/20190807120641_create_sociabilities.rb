class CreateSociabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :sociabilities do |t|
      t.string :name
      t.boolean :alert

      t.timestamps
    end
  end
end
