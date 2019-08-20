class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.references :person, polymorphic: true, index: true
      t.string :username
      t.string :password_digest

      t.timestamps
    end
  end
end
