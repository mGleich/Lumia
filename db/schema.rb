# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140208101333) do

  create_table "adresses", :force => true do |t|
    t.string   "street"
    t.integer  "zipcode"
    t.string   "city"
    t.text     "comment"
    t.integer  "client_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "house_number"
  end

  create_table "available_et_to_clients", :force => true do |t|
    t.integer  "client_id"
    t.integer  "event_type_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "marker"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "first_name"
    t.string   "sex"
    t.string   "migration"
    t.string   "community_needs"
    t.text     "comment"
    t.integer  "state_id"
    t.boolean  "lock"
    t.boolean  "data_release"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "reported_by_id"
    t.integer  "cp_in_jobcenter_id"
    t.integer  "another_cp_id"
    t.string   "birthday"
  end

  create_table "contact_partners", :force => true do |t|
    t.string   "name"
    t.string   "firstname"
    t.string   "tnumber"
    t.string   "email"
    t.string   "institution"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "emails_of_clients", :force => true do |t|
    t.string   "email"
    t.integer  "client_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "event_types", :force => true do |t|
    t.string   "description"
    t.string   "short_description"
    t.integer  "number"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "ancestry"
    t.boolean  "node"
    t.integer  "ancestry_depth",    :default => 0
  end

  add_index "event_types", ["ancestry"], :name => "index_event_types_on_ancestry"

  create_table "event_types_part_of_rules", :id => false, :force => true do |t|
    t.integer "event_type_id"
    t.integer "part_of_rule_id"
  end

  create_table "event_types_releases", :id => false, :force => true do |t|
    t.integer "event_type_id"
    t.integer "release_id"
  end

  create_table "event_types_results", :id => false, :force => true do |t|
    t.integer "event_type_id"
    t.integer "result_id"
  end

  create_table "events", :force => true do |t|
    t.text     "comment"
    t.integer  "event_type_id"
    t.integer  "employee_id"
    t.integer  "client_id"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "benefit_date"
    t.string   "template_again"
  end

  create_table "part_of_rules", :force => true do |t|
    t.string   "boperator"
    t.integer  "test_value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "rule_id"
  end

  create_table "regular_expressions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "regular_expressions_releases", :id => false, :force => true do |t|
    t.integer "regular_expression_id"
    t.integer "release_id"
  end

  create_table "regular_expressions_results", :id => false, :force => true do |t|
    t.integer "regular_expression_id"
    t.integer "result_id"
  end

  create_table "regular_expressions_rules", :id => false, :force => true do |t|
    t.integer "regular_expression_id"
    t.integer "rule_id"
  end

  create_table "releases", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "releases_states", :id => false, :force => true do |t|
    t.integer "release_id"
    t.integer "state_id"
  end

  create_table "results", :force => true do |t|
    t.integer  "state_id"
    t.string   "type"
    t.string   "info"
    t.string   "name"
    t.string   "event_type_operator"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "rules", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "condition"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "telenumbers_of_clients", :force => true do |t|
    t.string   "number"
    t.integer  "client_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "test_tables", :force => true do |t|
    t.string   "name"
    t.integer  "age"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "role"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
