class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.string :description
      t.string :short_description
      t.integer :number
      t.boolean :node

      t.timestamps
    end
  end
end
