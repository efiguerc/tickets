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

ActiveRecord::Schema.define(version: 20170323013251) do

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "body",       limit: 65535
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_comments_on_deleted_at", using: :btree
    t.index ["ticket_id"], name: "index_comments_on_ticket_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "tickets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "customer_id"
    t.string   "category"
    t.string   "title"
    t.text     "description", limit: 65535
    t.integer  "status"
    t.integer  "priority"
    t.integer  "agent_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.datetime "deleted_at"
    t.index ["agent_id"], name: "index_tickets_on_agent_id", using: :btree
    t.index ["customer_id"], name: "index_tickets_on_customer_id", using: :btree
    t.index ["deleted_at"], name: "index_tickets_on_deleted_at", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "access_token",           default: ""
    t.integer  "role"
    t.datetime "deleted_at"
    t.string   "name"
    t.index ["access_token"], name: "index_users_on_access_token", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "comments", "tickets"
  add_foreign_key "comments", "users"
  add_foreign_key "tickets", "users", column: "agent_id"
  add_foreign_key "tickets", "users", column: "customer_id"
end
