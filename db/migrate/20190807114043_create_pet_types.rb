class CreatePetTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_types do |t|
      t.string :animal

    end
  end
end
