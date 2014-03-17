class CreateRegularMachines < ActiveRecord::Migration
  def change
    create_table :regular_machines do |t|

      t.timestamps
    end
  end
end
