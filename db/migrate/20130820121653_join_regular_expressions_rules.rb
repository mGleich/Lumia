class JoinRegularExpressionsRules < ActiveRecord::Migration
  def up
    create_table :regular_expressions_rules, :id => false do |t|
      t.integer :regular_expression_id
      t.integer :rule_id
    end
  end

  def down
    drop_table :regular_expressions_rules
  end
end
