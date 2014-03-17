class Rule < ActiveRecord::Base
  has_many :part_of_rules, dependent: :destroy
  has_and_belongs_to_many :regular_expressions
  # attr_accessible :title, :body
  attr_accessible :type, :name
  #attr_accessor :parts_of_rule, :result, :release

  validates_presence_of :name, :type
  validates :name, uniqueness: true


  def execute_rule
  end

  def check_rule (client)
  end

  #def rule_with_parts (client)
  #  puts client.first_name
  #  j=0
    #Überprüfung der Teilregeln
  #  self.part_of_rules.each do |part_of_rule|
  #    i=0
      #aufzählen wie oft des Vorkommen der Ereignisse im Klienten die Teilregeln erfüllen
  #    part_of_rule.event_types.each do |event_type|
  #      if Event.where(:client_id => client.id, :event_type_id => event_type.id).size >= part_of_rule.test_value
  #        i=i+1
  #        puts part_of_rule.id
  #        puts i
  #      end
  #    end
  #    if part_of_rule.boperator == "UND" && part_of_rule.event_types.size == i
  #      puts "Und Teilregel ist erfullt"
  #      puts part_of_rule.id
  #      j=j+1
  #    end
  #    if part_of_rule.boperator == "ODER" && i > 0
  #      puts "Oder Teilregel erfullt"
  #      puts part_of_rule.id
  #      j=j+1
  #    end
  #  end

  #  if self.part_of_rules.size == j
  #    return true
      #An dieser Stelle kann das Ergebnis umgesetzt werden
  #  else
  #    return false
  #  end
  #end

  #def straight_rule (client)
  #  self.results.each do |result|
  #    result.execute(client)
  #  end
  #end
end
