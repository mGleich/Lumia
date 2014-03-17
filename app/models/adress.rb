class Adress < ActiveRecord::Base
  attr_accessible :city, :client_id, :comment, :house_number, :street, :zipcode
  belongs_to :client
end
