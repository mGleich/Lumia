class CreateAdresses < ActiveRecord::Migration
  def change
    create_table :adresses do |t|
      t.string :street
      t.string :house_number
      t.integer :zipcode
      t.string :city
      t.text :comment
      t.integer :client_id

      t.timestamps
    end
  end
end
