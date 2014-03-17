class RuleWithParts < Rule
  # attr_accessible :title, :body

  def check_rule(client)
    parts_counter=0 #Zähler der korreckten Teilregeln

    #Überprüfung der Teilregeln
    self.part_of_rules.each do |part_of_rule|

      #Hier werden alle Event Typen zusammengesucht Dient dazu um auch auf Nachfahren reagieren zu können.
      event_types = Array.new
      #Event Typen die einen Knoten bilden
      part_of_rule.event_types.where(:node => true).each do |node|
        event_types = event_types + node.descendants.where(:node => false)
      end
      #Event Typen die kein Knoten sind
      event_types = event_types + part_of_rule.event_types.where(:node => false)
      event_types = event_types.uniq

      #Abbruch Bedingung. Ist sie fünf dann soll die Schleife beendet werden
      #Sie ist nur fünf wenn etwas richtig oder falsch ist
      abort_condition = false

      array_pos = 0

      if part_of_rule.boperator == 'UND'
        while abort_condition == false
          if array_pos < event_types.size #Ist das Ende des Arrays erreicht?
            event_type = event_types[array_pos]
            #Überprüft ob es genug Events gibt die die Klient ID und vom EventTyp sind
            if Event.where(:client_id => client.id, :event_type_id => event_type.id).size >= part_of_rule.test_value
              #ja? dann wird zur nächsten Stelle gesprungen
              array_pos=array_pos+1
            else
              #nein dann kann die Bedingung abgebrochen werden
              abort_condition = true
            end
          else
            #ja kann die Bedingung abgebrochen werden
            #Bedingung ist korrekt +1
            parts_counter=parts_counter+1
            abort_condition = true
          end
        end
      end

      if part_of_rule.boperator == 'ODER'
        while abort_condition == false
          if array_pos < event_types.size #Ist das Ende des Arrays erreicht?
            event_type = event_types[array_pos] #Hole EventTyp
            if Event.where(:client_id => client.id, :event_type_id => event_type.id).size >= part_of_rule.test_value
              abort_condition = true
              parts_counter=parts_counter+1
            else
              array_pos = array_pos + 1
            end
          else
            abort_condition = true
          end
        end
      end
    end

    #sind alle Teilregeln erfüllt kann ein richtig oder falsch gesendet werden
    if self.part_of_rules.size == parts_counter
      return true
    else
      return false
    end
  end
end




