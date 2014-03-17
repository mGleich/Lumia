class JoinReleasesStates < ActiveRecord::Migration
  def up
    create_table :releases_states, :id => false do |t|
      t.integer :release_id
      t.integer :state_id
    end
  end

  def down
    drop_table :releases_states
  end
end
