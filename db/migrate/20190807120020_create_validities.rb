class CreateValidities < ActiveRecord::Migration[5.2]
  def change
    create_table :validities do |t|
      t.integer :code
      t.string :name

    end
  end
end
