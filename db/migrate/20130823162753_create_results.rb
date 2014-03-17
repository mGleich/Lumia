class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :state_id
      t.string :type
      t.string :info
      t.string :name
      t.string :event_type_operator
      t.timestamps
    end
  end
end
