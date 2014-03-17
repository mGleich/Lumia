class CreateEmailsOfClients < ActiveRecord::Migration
  def change
    create_table :emails_of_clients do |t|
      t.string :email
      t.integer :client_id

      t.timestamps
    end
  end
end
