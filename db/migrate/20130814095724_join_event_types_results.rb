class JoinEventTypesResults < ActiveRecord::Migration
  def up
    create_table :event_types_results, :id => false do |t|
      t.integer :event_type_id
      t.integer :result_id
    end
  end

  def down
    drop_table :event_types_results
  end
end
