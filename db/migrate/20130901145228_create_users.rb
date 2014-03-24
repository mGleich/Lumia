class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :role

      t.timestamps
    end

    User.create name: 'Admin', password: 'Admin', role: 'Administrator'
  end
end
