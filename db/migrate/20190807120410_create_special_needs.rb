class CreateSpecialNeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :special_needs do |t|
      t.string :special_need
      t.string :action_needed
      t.boolean :current, default: true

      t.timestamps
    end
  end
end
