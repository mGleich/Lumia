class CreateAvailableEtToClients < ActiveRecord::Migration
  def change
    create_table :available_et_to_clients do |t|
      t.integer :client_id
      t.integer :event_type_id
      t.integer :marker
      t.timestamps
    end
  end
end
