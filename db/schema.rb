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

ActiveRecord::Schema.define(:version => 20111129220937) do

  create_table "domains", :force => true do |t|
    t.integer  "site_id"
    t.string   "domain"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.integer  "site_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "default"
    t.text     "raw"
    t.text     "contents"
    t.string   "template"
    t.string   "meta_title"
    t.string   "meta_desc"
    t.string   "meta_author"
  end

  add_index "pages", ["site_id"], :name => "index_pages_on_site_id"

  create_table "sites", :force => true do |t|
    t.string   "subdomain"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "title"
    t.string   "theme"
  end

  add_index "sites", ["subdomain"], :name => "index_sites_on_subdomain"

  create_table "users", :force => true do |t|
    t.string   "email",           :null => false
    t.string   "password_digest", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
