class CreateHealthDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :health_details do |t|
      t.string :name
      t.boolean :alert

    end
  end
end
