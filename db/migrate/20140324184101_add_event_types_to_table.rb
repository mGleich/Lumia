class AddEventTypeInstances < ActiveRecord::Migration
  def change
    EventType.create description: 'Vom System erzeugt', short_description: 'Vom System erzeugt', number: 0000, node: true
    EventType.create description: 'Root fuer User Ereignistypen', short_description: 'Root fuer User Ereignistypen', number: 0000, node: true
  end
end
