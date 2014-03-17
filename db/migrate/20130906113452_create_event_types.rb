class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.string :description
      t.string :short_description
      t.integer :number
      t.integer :ancestry_depth, :default => 0
      t.boolean :node

      t.timestamps
    end

    EventType.create description: 'Vom System erzeugt', short_description: 'Vom System erzeugt', number: 0000, node: true
    EventType.create description: 'Root fuer User Ereignistypen', short_description: 'Root fuer User Ereignistypen', number: 0000, node: true
  end
end
