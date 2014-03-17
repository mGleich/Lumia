class JoinResultsStates < ActiveRecord::Migration
  def up
    create_table :results_states, :id => false do |t|
      t.integer :result_id
      t.integer :state_id
    end
  end

  def down
    drop_table :results_states
  end
end
