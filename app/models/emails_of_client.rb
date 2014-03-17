class EmailsOfClient < ActiveRecord::Base
  belongs_to :client
  attr_accessible :client_id, :email
end
