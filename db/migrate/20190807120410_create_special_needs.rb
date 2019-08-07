class CreateSpecialNeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :special_needs do |t|
      t.string :name
      t.string :action_needed

      t.timestamps
    end
  end
end
