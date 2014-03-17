class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :first_name
      t.string :sex
      t.string :birthday
      t.string :migration
      t.string :community_needs
      t.text :comment
      t.integer :state_id
      t.boolean :lock
      t.boolean :data_release  #datenfreigabe

      t.integer :reported_by_id #gemeldet_von
      t.integer :cp_in_jobcenter_id #Kontaktperson in Jobcenter
      t.integer :another_cp_id #andere Kontaktperson

      t.timestamps
    end
  end
end
