class CreateValidities < ActiveRecord::Migration[5.2]
  def change
    create_table :validities do |t|
      t.integer :code
      t.string :duration

      t.timestamps
    end
  end
end
