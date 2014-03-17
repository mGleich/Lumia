class JoinRegularExpressionsReleases < ActiveRecord::Migration
  def up
    create_table :regular_expressions_releases, :id => false do |t|
      t.integer :regular_expression_id
      t.integer :release_id
    end
  end

  def down
    drop_table :regular_expressions_releases
  end
end
