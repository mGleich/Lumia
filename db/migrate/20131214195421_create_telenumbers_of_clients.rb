class CreateTelenumbersOfClients < ActiveRecord::Migration
  def change
    create_table :telenumbers_of_clients do |t|
      t.string :number
      t.integer :client_id
      t.timestamps
    end
  end
end
