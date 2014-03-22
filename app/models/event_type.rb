class EventType < ActiveRecord::Base
  attr_accessible :description, :number, :short_description, :node, :parent_id
  has_many :events, dependent: :nullify
  has_and_belongs_to_many :part_of_rules
  has_and_belongs_to_many :releases
  has_and_belongs_to_many :results
  has_many :clients, through: :available_et_to_clients
  has_many :available_et_to_clients
  has_ancestry cache_depth: true

  validates_presence_of :description, :short_description
  validates :short_description, uniqueness: true

  def steps
    %w[zero first second third fourth fifth sixth]
  end

  def depth_next
    steps[(self.depth)+ 1]
  end

  def depth_name (num)
    steps[num]
  end
end
