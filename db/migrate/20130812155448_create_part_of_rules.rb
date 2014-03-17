class CreatePartOfRules < ActiveRecord::Migration
  def change
    create_table :part_of_rules do |t|
      t.string :boperator
      t.integer :test_value
      t.integer :rule_id

      t.timestamps
    end
  end
end
