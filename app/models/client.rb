class Client < ActiveRecord::Base
  attr_accessible :birthday, :comment, :community_needs, :first_name, :migration, :name, :sex, :state_id, :lock, :data_release, :reported_by_id, :cp_in_jobcenter_id, :another_cp_id

  belongs_to :state
  has_many :event_types, through: :available_et_to_clients
  has_many :available_et_to_clients, dependent: :destroy
  has_many :adresses, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :emails_of_clients, dependent: :destroy
  has_many :telenumbers_of_clients, dependent: :destroy
  belongs_to :reported_by, class_name: "ContactPartner", foreign_key: "reported_by_id"
  belongs_to :cp_in_jobcenter, class_name: "ContactPartner", foreign_key: "cp_in_jobcenter_id"
  belongs_to :another_cp, class_name: "ContactPartner", foreign_key: "another_cp_id"


  after_create :create_event

  validates_presence_of :name
  validates_presence_of :first_name

  #funktion zur Suche
  def self.search(search)
    if search
      where('name LIKE ? or first_name LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

  #Funktion die beim anlegen ausgelöst wird
  #Hier wird ein Ereignis vom System erzeugt und dem Klienten zugewiesen
  def create_event
    event = self.events.build
    event.comment = "Client wurde angelegt"
    event.event_type_id = 1
    event.save
  end
end
