# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081123050952) do

  create_table "addresses", :force => true do |t|
    t.integer "person_id",    :limit => 11
    t.boolean "preferred",                  :default => false
    t.string  "address_type",               :default => ""
    t.string  "street",                     :default => ""
    t.string  "city",                       :default => ""
    t.string  "state",                      :default => ""
    t.string  "postal_code",                :default => ""
    t.string  "geocode",                    :default => ""
    t.string  "country_name",               :default => ""
  end

  create_table "affiliations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "competencies", :force => true do |t|
    t.string   "name",        :default => ""
    t.string   "description", :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "competencies_people", :id => false, :force => true do |t|
    t.integer "competency_id", :limit => 11
    t.integer "person_id",     :limit => 11
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.integer  "people_count", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.string   "title",                           :default => ""
    t.text     "description"
    t.integer  "size",              :limit => 11
    t.string   "content_type"
    t.string   "filename"
    t.integer  "documentable_id",   :limit => 11
    t.string   "documentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_addresses", :force => true do |t|
    t.integer "person_id",     :limit => 11
    t.boolean "preferred",                   :default => false
    t.string  "email_type",                  :default => ""
    t.string  "email_address",               :default => ""
  end

  create_table "events", :force => true do |t|
    t.string   "event_type"
    t.string   "institution"
    t.string   "title"
    t.string   "city"
    t.datetime "start_date"
    t.datetime "finish_date"
    t.text     "notes",       :null => false
    t.string   "country"
  end

  create_table "fellowships", :force => true do |t|
    t.integer "program_id", :limit => 11
    t.integer "person_id",  :limit => 11
    t.string  "year",       :limit => 4
    t.string  "country"
  end

  create_table "im_addresses", :force => true do |t|
    t.integer "person_id",  :limit => 11
    t.boolean "preferred",                :default => false
    t.string  "im_type",                  :default => ""
    t.string  "im_address",               :default => ""
  end

  create_table "jobs", :force => true do |t|
    t.integer  "organization_id", :limit => 11,                    :null => false
    t.integer  "person_id",       :limit => 11,                    :null => false
    t.boolean  "current",                       :default => false
    t.string   "title",                         :default => ""
    t.text     "description"
    t.datetime "start_date"
    t.datetime "finish_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name",        :default => ""
    t.string   "url",         :default => ""
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "first_name",                        :default => ""
    t.string   "last_name",                         :default => ""
    t.string   "middle_name",                       :default => ""
    t.string   "name_prefix",                       :default => ""
    t.string   "name_suffix",                       :default => ""
    t.date     "bday"
    t.string   "gender",              :limit => 1,  :default => "F"
    t.datetime "updated_at"
    t.string   "company_name",                      :default => ""
    t.string   "job_title"
    t.datetime "created_at"
    t.integer  "user_id",             :limit => 11
    t.string   "primary_email_cache"
    t.string   "primary_phone_cache"
    t.integer  "photos_count",        :limit => 11, :default => 0,     :null => false
    t.integer  "fellowships_count",   :limit => 11, :default => 0,     :null => false
    t.integer  "country_id",          :limit => 11
    t.integer  "region_id",           :limit => 11
    t.integer  "affiliation_id",      :limit => 11
    t.boolean  "is_deceased",                       :default => false
  end

  create_table "phone_numbers", :force => true do |t|
    t.integer "person_id",         :limit => 11
    t.boolean "preferred",                       :default => false
    t.string  "phone_number_type",               :default => ""
    t.string  "phone_number",                    :default => ""
  end

  create_table "photos", :force => true do |t|
    t.integer  "person_id",    :limit => 11
    t.string   "title",                       :default => ""
    t.text     "body"
    t.datetime "created_at"
    t.boolean  "preferred",                   :default => false
    t.string   "content_type", :limit => 100
    t.string   "filename"
    t.string   "path"
    t.integer  "parent_id",    :limit => 11
    t.string   "thumbnail"
    t.integer  "size",         :limit => 11
    t.integer  "width",        :limit => 11
    t.integer  "height",       :limit => 11
  end

  create_table "profile_notes", :force => true do |t|
    t.integer "person_id", :limit => 11
    t.string  "note_type"
    t.text    "body"
  end

  create_table "programs", :force => true do |t|
    t.string   "title"
    t.string   "abbr"
    t.text     "notes"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "programs_events", :force => true do |t|
    t.integer "event_id",   :limit => 11
    t.integer "program_id", :limit => 11
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.integer  "country_id",   :limit => 11
    t.integer  "people_count", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "registrations", :force => true do |t|
    t.integer "event_id",      :limit => 11
    t.integer "person_id",     :limit => 11
    t.string  "participation"
    t.text    "notes"
    t.boolean "is_organizer",                :default => false
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id", :limit => 11, :null => false
    t.integer "user_id", :limit => 11, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "full_name"
    t.integer  "person_id",                 :limit => 11
    t.boolean  "enabled",                                 :default => false, :null => false
    t.datetime "last_login_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login"

  create_table "websites", :force => true do |t|
    t.integer "person_id",  :limit => 11
    t.string  "site_title",               :default => ""
    t.string  "site_url",                 :default => ""
    t.boolean "preferred",                :default => false
  end

end
