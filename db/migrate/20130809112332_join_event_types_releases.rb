class JoinEventTypesReleases < ActiveRecord::Migration
  def up
    create_table :event_types_releases, :id => false do |t|
      t.integer :event_type_id
      t.integer :release_id
    end
  end

  def down
    drop_table :event_types_releases
  end
end
