class CreateHealthDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :health_details do |t|
      t.string :health_detail

      t.timestamps
    end
  end
end
