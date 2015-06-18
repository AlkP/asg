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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140303154719) do

  create_table "clients", force: true do |t|
    t.string   "name"
    t.string   "legal_address"
    t.string   "actual_address"
    t.string   "inn"
    t.string   "kpp"
    t.string   "account"
    t.string   "name_bank"
    t.string   "corr_account"
    t.string   "bik"
    t.string   "job_title"
    t.string   "name_head"
    t.string   "job_title_genitive"
    t.string   "name_head_genitive"
    t.string   "statute"
    t.boolean  "deleted"
    t.integer  "sector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  add_index "clients", ["sector_id"], name: "index_clients_on_sector_id"

  create_table "contracts", force: true do |t|
    t.string   "name"
    t.string   "number"
    t.date     "date"
    t.float    "amount"
    t.boolean  "annex"
    t.integer  "template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
  end

  add_index "contracts", ["client_id"], name: "index_contracts_on_client_id"
  add_index "contracts", ["template_id"], name: "index_contracts_on_template_id"

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "international_name"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "note"
    t.date     "date"
    t.time     "time"
    t.boolean  "end"
    t.integer  "user_id"
    t.integer  "client_id"
    t.integer  "staff_id"
    t.integer  "tour_id"
    t.integer  "partner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["client_id"], name: "index_events_on_client_id"
  add_index "events", ["partner_id"], name: "index_events_on_partner_id"
  add_index "events", ["staff_id"], name: "index_events_on_staff_id"
  add_index "events", ["tour_id"], name: "index_events_on_tour_id"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "list_staff_tours", force: true do |t|
    t.integer  "tour_id"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "list_staff_tours", ["staff_id"], name: "index_list_staff_tours_on_staff_id"
  add_index "list_staff_tours", ["tour_id"], name: "index_list_staff_tours_on_tour_id"

  create_table "notes", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "deleted"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["client_id"], name: "index_notes_on_client_id"

  create_table "partners", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "contact_name"
    t.string   "email"
    t.string   "phone"
    t.string   "description"
    t.boolean  "deleted"
    t.integer  "types_partner_id"
    t.integer  "country_id"
    t.integer  "town_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "partners", ["country_id"], name: "index_partners_on_country_id"
  add_index "partners", ["town_id"], name: "index_partners_on_town_id"
  add_index "partners", ["types_partner_id"], name: "index_partners_on_types_partner_id"

  create_table "post_dispatch_emails", force: true do |t|
    t.string   "email"
    t.integer  "post_dispatch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_dispatch_emails", ["post_dispatch_id"], name: "index_post_dispatch_emails_on_post_dispatch_id"

  create_table "post_dispatch_logs", force: true do |t|
    t.integer  "post_dispatch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_dispatch_logs", ["post_dispatch_id"], name: "index_post_dispatch_logs_on_post_dispatch_id"

  create_table "post_dispatches", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.string   "whom"
    t.text     "list"
    t.string   "periodicity"
    t.string   "date"
    t.time     "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_staffs", force: true do |t|
    t.integer  "tour_room_id"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "room_staffs", ["staff_id"], name: "index_room_staffs_on_staff_id"
  add_index "room_staffs", ["tour_room_id"], name: "index_room_staffs_on_tour_room_id"

  create_table "sectors", force: true do |t|
    t.string   "name"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staff_notes", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "deleted"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "staff_notes", ["staff_id"], name: "index_staff_notes_on_staff_id"

  create_table "staff_visas", force: true do |t|
    t.date     "validity"
    t.boolean  "deleted"
    t.integer  "country_id"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "staff_visas", ["country_id"], name: "index_staff_visas_on_country_id"
  add_index "staff_visas", ["staff_id"], name: "index_staff_visas_on_staff_id"

  create_table "staffs", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "middle_name"
    t.string   "series"
    t.string   "issued_by"
    t.string   "issue_date"
    t.string   "valid_until"
    t.string   "international_name"
    t.string   "international_surname"
    t.string   "international_middle_name"
    t.string   "international_series"
    t.string   "international_issued_by"
    t.string   "international_issue_date"
    t.string   "international_valid_until"
    t.string   "sex"
    t.string   "post"
    t.string   "email_1"
    t.string   "email_2"
    t.string   "phone_1"
    t.string   "phone_2"
    t.string   "phone_3"
    t.string   "registration"
    t.string   "lives"
    t.boolean  "deleted"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "birthday"
  end

  add_index "staffs", ["client_id"], name: "index_staffs_on_client_id"

  create_table "templates", force: true do |t|
    t.string   "name"
    t.string   "att_file_file_name"
    t.string   "att_file_content_type"
    t.integer  "att_file_file_size"
    t.datetime "att_file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tour_notes", force: true do |t|
    t.string   "name"
    t.boolean  "deleted"
    t.integer  "tour_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tour_notes", ["tour_id"], name: "index_tour_notes_on_tour_id"

  create_table "tour_rooms", force: true do |t|
    t.string   "name"
    t.integer  "tour_id"
    t.integer  "partner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tour_rooms", ["partner_id"], name: "index_tour_rooms_on_partner_id"
  add_index "tour_rooms", ["tour_id"], name: "index_tour_rooms_on_tour_id"

  create_table "tours", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "note"
    t.date     "departure"
    t.date     "final"
    t.boolean  "archive"
    t.boolean  "deleted"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tours", ["client_id"], name: "index_tours_on_client_id"

  create_table "towns", force: true do |t|
    t.string   "name"
    t.string   "international_name"
    t.boolean  "deleted"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "towns", ["country_id"], name: "index_towns_on_country_id"

  create_table "types_partners", force: true do |t|
    t.string   "name"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visas", force: true do |t|
    t.integer  "duration"
    t.float    "cost"
    t.boolean  "deleted"
    t.integer  "country_id"
    t.integer  "partner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visas", ["country_id"], name: "index_visas_on_country_id"
  add_index "visas", ["partner_id"], name: "index_visas_on_partner_id"

end
