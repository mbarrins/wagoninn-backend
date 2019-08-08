class CreatePhoneTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :phone_types do |t|
      t.string :phone_type

    end
  end
end
