class CreatePhoneTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :phone_types do |t|
      t.string :name
      
    end
  end
end
