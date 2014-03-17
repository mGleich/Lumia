class AddAncestryToEventTypes < ActiveRecord::Migration
  def self.up
    add_column :event_types, :ancestry, :string
    add_index :event_types, :ancestry
  end

  def self.down
    remove_index :event_types, :ancestry
    remove_column :event_types, :ancestry
  end
end
