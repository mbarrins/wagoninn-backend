class CreateOwners < ActiveRecord::Migration[5.2]
  def change
    create_table :owners do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :primary_phone
      t.references :primary_phone_type, index: true, foreign_key: { to_table: :phone_types }
      t.string :secondary_phone
      t.references :secondary_phone_type, index: true, foreign_key: { to_table: :phone_types }
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_line_3
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :emergency_contact_name
      t.string :emergency_contact_phone
      t.string :partner_name
      t.string :partner_phone
      t.boolean :agreed_terms
      t.date :agreed_date
      t.text :notes
      t.text :online_access_code

      t.timestamps
    end
  end
end
