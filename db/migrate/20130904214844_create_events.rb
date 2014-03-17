class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :comment
      t.string :benefit_date
      t.string :template_again
      t.integer :event_type_id
      t.integer :employee_id
      t.integer :client_id
      t.integer :user_id
      t.integer :state_id

      t.timestamps
    end
  end
end
