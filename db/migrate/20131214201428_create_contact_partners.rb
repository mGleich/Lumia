class CreateContactPartners < ActiveRecord::Migration
  def change
    create_table :contact_partners do |t|
      t.string :name
      t.string :firstname
      t.string :tnumber
      t.string :email
      t.string :institution

      t.timestamps
    end
  end
end
