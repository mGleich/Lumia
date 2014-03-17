class RegularExpression < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :results
  has_and_belongs_to_many :releases
  has_and_belongs_to_many :rules

  validates_presence_of :name
  validates :name, uniqueness: true
end
