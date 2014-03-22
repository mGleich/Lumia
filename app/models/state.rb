class State < ActiveRecord::Base
  attr_accessible :condition
  has_many :results, dependent: :nullify
  has_and_belongs_to_many :releases
  has_many :clients, dependent: :nullify

  validates_presence_of :condition
  validates :condition, uniqueness: true
end
