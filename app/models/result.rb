class Result < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :state
  has_and_belongs_to_many :regular_expressions
  has_and_belongs_to_many :event_types
  attr_accessor :stati
  attr_accessible :state_id, :info, :name, :event_type_operator, :type

  validates :name, uniqueness: true
  validates_presence_of :type, :name

  def stati
    stati = ''
    stati = self.state.condition
    return stati
  end

  def execute_result (client)
    puts 'You made something wrong'
  end
end
