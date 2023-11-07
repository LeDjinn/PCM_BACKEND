# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_10_190226) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "country"
    t.string "email"
    t.string "phone_number"
    t.string "siret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "individuals", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number" 
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_individuals_on_company_id"
  end

  create_table "losses", force: :cascade do |t|
    t.integer "dn"
    t.float "lenght_useful"
    t.float "loss_orhto"
    t.float "loss_helico"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matters", force: :cascade do |t|
    t.string "name"
    t.float "price_local"
    t.float "price_export"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_matters_on_category_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_quotations_on_company_id"
  end

  create_table "ratios", force: :cascade do |t|
    t.integer "dn"
    t.float "tps_demandrinage"
    t.float "ratio_ac"
    t.float "ratio_rm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tubes", force: :cascade do |t|
    t.string "country"
    t.integer "pressure"
    t.string "mat"
    t.string "type_piece"
    t.integer "dn"
    t.float "ac"
    t.float "rm"
    t.integer "quantity"
    t.integer "price_mo"
    t.string "voile_ac"
    t.string "barear_ac"
    t.string "charge_ac"
    t.string "resine_rm"
    t.string "charge_rm"
    t.string "color"
    t.integer "number_voile_ac"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "quotation_id", null: false
    t.index ["quotation_id"], name: "index_tubes_on_quotation_id"
  end

  add_foreign_key "individuals", "companies"
  add_foreign_key "matters", "categories"
  add_foreign_key "quotations", "companies"
  add_foreign_key "tubes", "quotations"
end
