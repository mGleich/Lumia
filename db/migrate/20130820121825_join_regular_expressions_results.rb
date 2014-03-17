class JoinRegularExpressionsResults < ActiveRecord::Migration
  def up
    create_table :regular_expressions_results, :id => false do |t|
      t.integer :regular_expression_id
      t.integer :result_id
    end
  end

  def down
    drop_table :regular_expressions_results
  end
end
