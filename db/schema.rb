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

ActiveRecord::Schema.define(version: 20170904100000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "kls_unicode"
    t.integer  "kls_parent"
    t.integer  "kls_childcount"
  end

  create_table "groups_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "group_id"
    t.index ["product_id", "group_id"], name: "prices_grp_prod_idx", using: :btree
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "number_invoice"
    t.string   "phone_invoice"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "email"
    t.string   "status"
    t.string   "place"
    t.float    "summ"
    t.decimal  "summ_n"
    t.integer  "inv"
    t.integer  "pharmacy_id"
    t.integer  "user_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer  "goodsid"
    t.float    "price"
    t.integer  "qnt"
    t.integer  "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal  "price1"
  end

  create_table "max_prc", id: false, force: :cascade do |t|
    t.decimal "max"
  end

  create_table "percentages", force: :cascade do |t|
    t.decimal  "val_fact_1"
    t.decimal  "val_fact_2"
    t.decimal  "percent_fact"
    t.decimal  "val_inv_1"
    t.decimal  "val_inv_2"
    t.decimal  "percent_inv"
    t.integer  "group_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "pharmacy_id"
    t.index ["group_id", "pharmacy_id"], name: "grp_prod_idx", using: :btree
  end

  create_table "pharmacies", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "adress"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "status"
    t.string   "timeopen"
    t.string   "phone"
    t.integer  "pharmacy_web_id"
    t.integer  "region_id"
    t.integer  "user_id"
  end

  create_table "pharmacy_webs", force: :cascade do |t|
    t.string   "name"
    t.string   "director"
    t.string   "phone"
    t.string   "addres"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "price_avas", force: :cascade do |t|
    t.integer  "cmp_u"
    t.decimal  "price"
    t.integer  "qnt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prices", force: :cascade do |t|
    t.decimal  "price"
    t.integer  "product_id"
    t.integer  "pharmacy_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.decimal  "price_nal"
    t.index ["product_id", "pharmacy_id"], name: "prices_prod_pharm_idx", using: :btree
    t.index ["product_id"], name: "idx_product_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.integer  "qtn"
    t.text     "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id"
    t.integer  "ext_id"
    t.decimal  "price1"
    t.index "name gist_trgm_ops", name: "trgm_idx", using: :gist
    t.index ["id"], name: "idx_id", using: :btree
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rls", force: :cascade do |t|
    t.text     "mnn"
    t.text     "composition"
    t.text     "indic"
    t.text     "unindic"
    t.text     "method"
    t.text     "limit"
    t.text     "overdose"
    t.text     "precaut"
    t.text     "pregnan"
    t.text     "text"
    t.text     "sideact"
    t.text     "pharmact"
    t.text     "pharmak"
    t.text     "actonorg"
    t.text     "compsprop"
    t.text     "specguid"
    t.text     "charactres"
    t.text     "drugform"
    t.text     "clinic"
    t.text     "direct"
    t.text     "inst"
    t.text     "recomend"
    t.text     "comment"
    t.text     "manufact"
    t.text     "liter"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "ext_id"
    t.text     "pharmadynamic"
    t.text     "interaction"
  end

  create_table "special_offers", force: :cascade do |t|
    t.decimal  "price1"
    t.integer  "prt_currQnt"
    t.integer  "pharmacy_id"
    t.string   "date_god"
    t.integer  "ext_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
