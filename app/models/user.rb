class User < ActiveRecord::Base
  has_many :events
  attr_accessible :name, :password, :password_confirmation, :role
  has_secure_password
  validates_presence_of :name, uniqueness: true
  validates_presence_of :password, :on => :create
  validates_presence_of :role, :on => :create
end
