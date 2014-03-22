class ResultStateChange < Result
  # attr_accessible :title, :body
  validates_presence_of :state_id

  def execute_result (client)
    if self.state != nil
    event = client.events.build
    if client.state == nil
      event.comment = "Statusaenderung durch das System zu #{self.state.condition}"
    else
      event.comment = "Statusaenderung durch das System von #{client.state.condition} zu #{self.state.condition}"
    end

    event.event_type_id = 1 #zeigt das das Event vom System erzeugt wurde
    client.state = self.state
    client.save
    event.save
    end
  end
end
