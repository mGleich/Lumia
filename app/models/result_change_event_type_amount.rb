class ResultChangeEventTypeAmount < Result
  # attr_accessible :title, :body
  validates_presence_of :event_type_operator

  def execute_result (client)

    if self.event_type_operator == 'Zur Menge Hinzufuegen'
      self.event_types.each do |event_type|
            #schaue nach ob EventTyp auf der schwarzen Liste ist
            entry = AvailableEtToClient.where(:client_id => client.id, :event_type_id => event_type.id).first
            if entry == nil #wenn Eintrag nicht vorhanden ist dann kann dieser hinzugefügt werden
              client.event_types << event_type
              client.save
            end
      end
    end

     #Die Priorität liegt darin EventTypen die aus der Menge entfernt werden
     #sollen auch gelöscht auch wenn andere Ergebnisse was anderes sagen
    # sind Einträge mit -1 markiert werden diese in der regular Machine gelöscht
    if self.event_type_operator == "Aus Menge entfernen"
      self.event_types.each do |event_type|
        if event_type.node == true #wenn es ein Knoten ist werden alle seine Blätter mit einem -1 markiert
          event_type.descendants.each do |f|
            entry = AvailableEtToClient.where(:client_id => client.id, :event_type_id => f.id).first #ersetzen durch find_by
            if entry == nil
              client.event_types << f
              client.save
              entry = AvailableEtToClient.where(:client_id => client.id, :event_type_id => f.id).first #ersetzen durch find_by
              entry.marker = -1
            else
              entry.marker = -1
            end
            entry.save
          end
        else
          entry = AvailableEtToClient.where(:client_id => client.id, :event_type_id => event_type.id).first
          if entry == nil
            client.event_types << event_type
            client.save
            entry = AvailableEtToClient.where(:client_id => client.id, :event_type_id => event_type.id).first
            entry.marker = -1
          else
            entry.marker = -1
          end
          entry.save
        end
      end
    end

    #Es sollen alle EventTypen für den Client gelöscht werden
    if self.event_type_operator == "Alle Ereignistypen loeschen"
      AvailableEtToClient.where(:client_id => client.id).each do |entry|
        entry.marker = -1
        entry.save
      end
    end

    #Es werden alle verfügbaren EventTypen hinzugefügt werden
    if self.event_type_operator == "Alle Ereignistypen hinzufuegen"
      EventType.where(:node => false).each do |event_type|
        entry = AvailableEtToClient.where(:client_id => client.id, :event_type_id => event_type.id)
        if entry.empty?
          client.event_types << event_type
        end
      end
    end
    client.save
  end
end
