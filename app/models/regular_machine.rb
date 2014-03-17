class RegularMachine < ActiveRecord::Base
  # attr_accessible :title, :body

  #Befehle die dazu dienen das keine Tabelle angelegt werden
  def self.columns()
    @columns ||= [];
  end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  def check_event(event)
    result_list = Array.new
    client = Client.find(event.client_id)

    # Vor jeder ausführung jeder Regel wird der Kommentar gelöscht
    client.comment = ""

    # Hier wird nach den Auslösern gesucht.
    # Hat der CLient keinen Status wird nach Auslösern ohne Status und EventTyp1(vom System Erzeugt) gesucht
    # Der Grund ist der das man schwehr Auslöser findet die weder EventTypen noch Status enthalten
    # Um die Suche zu beschleunigen grenzen wir die Auslöser darauf ein in dem wir sagen alle vom System erzeugten Ereignisse
    if client.state_id == nil && event.event_type_id == 1
      releases = Array.new
      EventType.find(event.event_type_id).releases.each do |release|
        if release.states.size == 0
        releases << release
        end
      end
    else
      #Auslöser anhand des Status des Clienten und dem EventTypen suchen
      releases = State.find(client.state_id).releases & EventType.find(event.event_type_id).releases
      #reagiert auch auf die Vaterelemente des Eventtypen und fügt dieser der Menge hinzu
      EventType.find(event.event_type_id).ancestors.each do |ancestor|
        ancestor_releases = State.find(client.state_id).releases & EventType.find(ancestor.id).releases
        releases = releases + ancestor_releases
      end

      #kümmere dich um auslöser ohne EventTyp gibt keine Notwendigkeit für die Funktion
      #State.find(client.state_id).releases.each do |release|
      #  if release.event_types.size == 0
      #    releases << release
      #  end
      #end

      releases = releases.uniq
    end

    releases.each do |release|
      #hole die Regeln Ausdrücke zum Auslöser
      @regular_expressions = Release.find(release.id).regular_expressions
      @regular_expressions.each do |regular_expression|
        @rules = regular_expression.rules
        i = 0

        @rules.each do |rule| #überprüfe jede einzelne Regel
          if rule.check_rule(client) == true
            i = i + 1
          end
        end
        #sind alle Regeln eines Regelausdruckes erfüllt gehe zum Ergebnis
        if @rules.size == i
          regular_expression.results.each do |result|
            if result.type == "ResultStateChange"
              #werfe alle Ergebnisse die den Status wechseln in eine Liste
              #Ein Statuswechsel soll einen Ereigniseintrag erzeugen
              result_list << result
            else
              #keine Statuswechsel können sofort ausgeführt werden
              result.execute_result(client)
            end
          end
        end
      end
    end
    #Hat einen Vorteil wenn der Eintrag hier steht.
    #EventTypen wo man sicher gehen will das sie gelöscht werden, werden hier gelöscht
    AvailableEtToClient.where(:client_id => client.id, :marker => -1).each do |entry|
      entry.destroy
    end

    #sichergehen das keine doppelten Statusänderungen durchgeführt werden
    result_list = result_list.uniq
    #Statusänderungen
    if result_list.size > 0
      result_list.each do |result_from_list|
        result_from_list.execute_result(client)
      end
    end
  end
end