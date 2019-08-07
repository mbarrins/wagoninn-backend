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

ActiveRecord::Schema.define(version: 2019_08_07_123554) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "booking_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "breeds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cares", force: :cascade do |t|
    t.string "name"
    t.boolean "alert"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "concerns", force: :cascade do |t|
    t.string "name"
    t.boolean "alert"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "health_details", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "immunisations", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "measures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medications", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "person_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pet_health_details", force: :cascade do |t|
    t.bigint "pet_id"
    t.bigint "health_detail_id"
    t.date "effective_from"
    t.date "effective_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["health_detail_id"], name: "index_pet_health_details_on_health_detail_id"
    t.index ["pet_id"], name: "index_pet_health_details_on_pet_id"
  end

  create_table "pet_immunisations", force: :cascade do |t|
    t.bigint "pet_id"
    t.bigint "immunisation_id"
    t.bigint "validity_id"
    t.date "effective_date"
    t.date "expiry_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["immunisation_id"], name: "index_pet_immunisations_on_immunisation_id"
    t.index ["pet_id"], name: "index_pet_immunisations_on_pet_id"
    t.index ["validity_id"], name: "index_pet_immunisations_on_validity_id"
  end

  create_table "pet_medications", force: :cascade do |t|
    t.bigint "pet_id"
    t.bigint "medication_id"
    t.bigint "dose_id"
    t.integer "dose_quantity"
    t.bigint "schedule_id"
    t.date "effective_from"
    t.date "effective_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dose_id"], name: "index_pet_medications_on_dose_id"
    t.index ["medication_id"], name: "index_pet_medications_on_medication_id"
    t.index ["pet_id"], name: "index_pet_medications_on_pet_id"
    t.index ["schedule_id"], name: "index_pet_medications_on_schedule_id"
  end

  create_table "pet_special_needs", force: :cascade do |t|
    t.bigint "pet_id"
    t.bigint "special_need_id"
    t.date "effective_from"
    t.date "effective_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_pet_special_needs_on_pet_id"
    t.index ["special_need_id"], name: "index_pet_special_needs_on_special_need_id"
  end

  create_table "pet_types", force: :cascade do |t|
    t.string "animal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pets", force: :cascade do |t|
    t.bigint "pet_type_id"
    t.string "name"
    t.date "dob"
    t.bigint "sex_id"
    t.bigint "color_id"
    t.bigint "size_id"
    t.bigint "breed_id"
    t.boolean "spayed_neutered"
    t.text "notes"
    t.boolean "special_needs_fee"
    t.boolean "no_return"
    t.boolean "inactive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["breed_id"], name: "index_pets_on_breed_id"
    t.index ["color_id"], name: "index_pets_on_color_id"
    t.index ["pet_type_id"], name: "index_pets_on_pet_type_id"
    t.index ["sex_id"], name: "index_pets_on_sex_id"
    t.index ["size_id"], name: "index_pets_on_size_id"
  end

  create_table "phone_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "room_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.string "name"
    t.string "fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sexes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sizes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sociabilities", force: :cascade do |t|
    t.string "name"
    t.boolean "alert"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "special_needs", force: :cascade do |t|
    t.string "name"
    t.string "action_needed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "validities", force: :cascade do |t|
    t.string "code"
    t.string "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "pet_health_details", "health_details"
  add_foreign_key "pet_health_details", "pets"
  add_foreign_key "pet_immunisations", "immunisations"
  add_foreign_key "pet_immunisations", "pets"
  add_foreign_key "pet_immunisations", "validities"
  add_foreign_key "pet_medications", "doses"
  add_foreign_key "pet_medications", "medications"
  add_foreign_key "pet_medications", "pets"
  add_foreign_key "pet_medications", "schedules"
  add_foreign_key "pet_special_needs", "pets"
  add_foreign_key "pet_special_needs", "special_needs"
  add_foreign_key "pets", "breeds"
  add_foreign_key "pets", "colors"
  add_foreign_key "pets", "pet_types"
  add_foreign_key "pets", "sexes"
  add_foreign_key "pets", "sizes"
end
