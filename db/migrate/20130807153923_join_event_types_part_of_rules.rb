class JoinEventTypesPartOfRules < ActiveRecord::Migration
  def up
    create_table :event_types_part_of_rules, :id => false do |t|
      t.integer :event_type_id
      t.integer :part_of_rule_id
    end
  end

  def down
    drop_table :event_types_part_of_rules
  end
end
