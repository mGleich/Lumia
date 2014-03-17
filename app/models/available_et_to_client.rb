class AvailableEtToClient < ActiveRecord::Base
  #eigenes Model für die Beziehung zwischen EventTypes und Clients
  attr_accessible :client_id, :event_type_id
  belongs_to :event_type
  belongs_to :client
end
