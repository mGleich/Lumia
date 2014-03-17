class TelenumbersOfClient < ActiveRecord::Base
  attr_accessible :number
  belongs_to :client
end
