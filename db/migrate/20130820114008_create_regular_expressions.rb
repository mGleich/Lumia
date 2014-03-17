class CreateRegularExpressions < ActiveRecord::Migration
  def change
    create_table :regular_expressions do |t|
      t.string :name

      t.timestamps
    end
  end
end
