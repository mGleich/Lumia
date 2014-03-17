class Event < ActiveRecord::Base
  attr_accessible :benefit_date, :client_id, :comment, :event_type_id, :template_again, :user_id
  belongs_to :event_type
  belongs_to :user
  belongs_to :client
  validates_presence_of :client_id, :event_type_id

  after_save :check_event

  def check_event
    RegularMachine.new.check_event(self)
  end

  #validates_presence_of :client_id

end
