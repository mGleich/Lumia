class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :condition

      t.timestamps
    end
  end
end
