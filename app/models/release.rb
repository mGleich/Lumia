class Release < ActiveRecord::Base
  # attr_accessible :title, :body
  has_and_belongs_to_many :regular_expressions
  has_and_belongs_to_many :event_types
  has_and_belongs_to_many :states
  attr_accessor :event_amount, :stati
  attr_accessible :name

  validates_presence_of :name
  validates :name, uniqueness: true

  def event_amount
    event_amount = ''
    self.event_types.each do |event_type|
      event_amount << event_type.short_description
      event_amount << ';'
    end
    return event_amount
  end

  def stati
    stati = ''
    if self.states.size != nil
      self.states.each do |state|
        stati << state.condition
        stati << ';'
      end
    end
    return stati
  end
end
