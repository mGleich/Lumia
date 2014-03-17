class PartOfRule < ActiveRecord::Base
  attr_accessible :boperator, :test_value, :name , :rule_id
  attr_accessor :event_amount
  has_and_belongs_to_many :event_types
  belongs_to :rule

  validates_presence_of :boperator, :test_value

  #validates_presence_of :name
  #validates :name, uniqueness: true

  #Methoden zur Hilfe der Beschriftung in den Zellen der Tabellen
  def event_amount
    event_amount = ''
    self.event_types.each do |event_type|
      event_amount << event_type.short_description
      event_amount << ';'
    end
    return event_amount
  end

end
