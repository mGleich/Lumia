class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :role

      t.timestamps
    end

    User.create  name:'Standart', password_digest:'$2a$10$OjhZKBcC9tBoi6FggX5t8u/MW8YBqc/1w87lQNR.q8RWKljPZRga2', role: 'Administrator'
  end
end
