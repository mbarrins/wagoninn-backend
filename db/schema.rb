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

ActiveRecord::Schema.define(version: 2019_08_08_085747) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "household_id"
    t.string "line_1"
    t.string "line_2"
    t.string "line_3"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.date "effective_from"
    t.date "effective_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["household_id"], name: "index_addresses_on_household_id"
  end

  create_table "booking_pen_pet_medications", force: :cascade do |t|
    t.bigint "booking_pen_pet_id"
    t.bigint "medication_id"
    t.bigint "dose_id"
    t.integer "dose_quantity"
    t.bigint "schedule_id"
    t.decimal "fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_pen_pet_id"], name: "index_booking_pen_pet_medications_on_booking_pen_pet_id"
    t.index ["dose_id"], name: "index_booking_pen_pet_medications_on_dose_id"
    t.index ["medication_id"], name: "index_booking_pen_pet_medications_on_medication_id"
    t.index ["schedule_id"], name: "index_booking_pen_pet_medications_on_schedule_id"
  end

  create_table "booking_pen_pet_special_needs", force: :cascade do |t|
    t.bigint "booking_pen_pet_id"
    t.bigint "special_need_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_pen_pet_id"], name: "index_booking_pen_pet_special_needs_on_booking_pen_pet_id"
    t.index ["special_need_id"], name: "index_booking_pen_pet_special_needs_on_special_need_id"
  end

  create_table "booking_pen_pets", force: :cascade do |t|
    t.bigint "booking_pen_id"
    t.bigint "pet_id"
    t.bigint "rate_id"
    t.boolean "special_needs_fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_pen_id"], name: "index_booking_pen_pets_on_booking_pen_id"
    t.index ["pet_id"], name: "index_booking_pen_pets_on_pet_id"
    t.index ["rate_id"], name: "index_booking_pen_pets_on_rate_id"
  end

  create_table "booking_pens", force: :cascade do |t|
    t.bigint "booking_id"
    t.bigint "pen_type_id"
    t.bigint "pen_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_booking_pens_on_booking_id"
    t.index ["pen_id"], name: "index_booking_pens_on_pen_id"
    t.index ["pen_type_id"], name: "index_booking_pens_on_pen_type_id"
  end

  create_table "booking_statuses", force: :cascade do |t|
    t.string "name"
  end

  create_table "bookings", force: :cascade do |t|
    t.string "booking_ref"
    t.bigint "household_id"
    t.date "check_in"
    t.string "check_in_time"
    t.date "check_out"
    t.string "check_out_time"
    t.bigint "booking_status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_status_id"], name: "index_bookings_on_booking_status_id"
    t.index ["household_id"], name: "index_bookings_on_household_id"
  end

  create_table "breeds", force: :cascade do |t|
    t.string "name"
    t.boolean "banned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string "name"
  end

  create_table "concerns", force: :cascade do |t|
    t.string "name"
    t.boolean "alert"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doses", force: :cascade do |t|
    t.string "name"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
  end

  create_table "health_details", force: :cascade do |t|
    t.string "name"
  end

  create_table "household_concerns", force: :cascade do |t|
    t.bigint "household_id"
    t.bigint "concerns_id"
    t.boolean "inactive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concerns_id"], name: "index_household_concerns_on_concerns_id"
    t.index ["household_id"], name: "index_household_concerns_on_household_id"
  end

  create_table "household_pen_pets", force: :cascade do |t|
    t.bigint "household_pen_id"
    t.bigint "pet_id"
    t.bigint "rate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["household_pen_id"], name: "index_household_pen_pets_on_household_pen_id"
    t.index ["pet_id"], name: "index_household_pen_pets_on_pet_id"
    t.index ["rate_id"], name: "index_household_pen_pets_on_rate_id"
  end

  create_table "household_pens", force: :cascade do |t|
    t.bigint "household_id"
    t.bigint "pen_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["household_id"], name: "index_household_pens_on_household_id"
    t.index ["pen_type_id"], name: "index_household_pens_on_pen_type_id"
  end

  create_table "household_people", force: :cascade do |t|
    t.bigint "household_id"
    t.bigint "person_id"
    t.bigint "person_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["household_id"], name: "index_household_people_on_household_id"
    t.index ["person_id"], name: "index_household_people_on_person_id"
    t.index ["person_type_id"], name: "index_household_people_on_person_type_id"
  end

  create_table "households", force: :cascade do |t|
    t.boolean "agreed_terms"
    t.string "agreed_person_id"
    t.date "agreed_date"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "immunisations", force: :cascade do |t|
    t.bigint "pet_type_id"
    t.string "name"
    t.boolean "current", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_type_id"], name: "index_immunisations_on_pet_type_id"
  end

  create_table "issues", force: :cascade do |t|
    t.string "name"
    t.boolean "alert"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "measures", force: :cascade do |t|
    t.string "name"
  end

  create_table "medications", force: :cascade do |t|
    t.string "name"
  end

  create_table "pen_types", force: :cascade do |t|
    t.bigint "pet_type_id"
    t.string "name"
    t.index ["pet_type_id"], name: "index_pen_types_on_pet_type_id"
  end

  create_table "pens", force: :cascade do |t|
    t.bigint "room_type_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_type_id"], name: "index_pens_on_room_type_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "job"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "person_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "pet_foods", force: :cascade do |t|
    t.bigint "pet_id"
    t.bigint "food_id"
    t.integer "quantity"
    t.bigint "measure_id"
    t.bigint "schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_pet_foods_on_food_id"
    t.index ["measure_id"], name: "index_pet_foods_on_measure_id"
    t.index ["pet_id"], name: "index_pet_foods_on_pet_id"
    t.index ["schedule_id"], name: "index_pet_foods_on_schedule_id"
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

  create_table "pet_issues", force: :cascade do |t|
    t.bigint "pet_id"
    t.bigint "issues_id"
    t.boolean "inactive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issues_id"], name: "index_pet_issues_on_issues_id"
    t.index ["pet_id"], name: "index_pet_issues_on_pet_id"
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

  create_table "pet_sociabilities", force: :cascade do |t|
    t.bigint "pet_id"
    t.bigint "sociability_id"
    t.boolean "inactive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_pet_sociabilities_on_pet_id"
    t.index ["sociability_id"], name: "index_pet_sociabilities_on_sociability_id"
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
    t.string "name"
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
  end

  create_table "phones", force: :cascade do |t|
    t.bigint "phone_type_id"
    t.bigint "person_id"
    t.string "number"
    t.string "extension"
    t.date "effective_from"
    t.date "effective_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_phones_on_person_id"
    t.index ["phone_type_id"], name: "index_phones_on_phone_type_id"
  end

  create_table "rates", force: :cascade do |t|
    t.bigint "pet_type_id"
    t.integer "no"
    t.string "desc"
    t.decimal "amount"
    t.date "effective_from"
    t.date "effective_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_type_id"], name: "index_rates_on_pet_type_id"
  end

  create_table "room_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "schedules", force: :cascade do |t|
    t.string "name"
    t.string "fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sexes", force: :cascade do |t|
    t.string "name"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "name"
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
    t.boolean "current", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_types", force: :cascade do |t|
    t.string "position"
    t.boolean "allow_override"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.bigint "user_type_id"
    t.string "first_name"
    t.string "last_name"
    t.string "job_title"
    t.string "email"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_type_id"], name: "index_users_on_user_type_id"
  end

  create_table "validities", force: :cascade do |t|
    t.integer "code"
    t.string "duration"
  end

  add_foreign_key "addresses", "households"
  add_foreign_key "booking_pen_pet_medications", "booking_pen_pets"
  add_foreign_key "booking_pen_pet_medications", "doses"
  add_foreign_key "booking_pen_pet_medications", "medications"
  add_foreign_key "booking_pen_pet_medications", "schedules"
  add_foreign_key "booking_pen_pet_special_needs", "booking_pen_pets"
  add_foreign_key "booking_pen_pet_special_needs", "special_needs"
  add_foreign_key "booking_pen_pets", "booking_pens"
  add_foreign_key "booking_pen_pets", "pets"
  add_foreign_key "booking_pen_pets", "rates"
  add_foreign_key "booking_pens", "bookings"
  add_foreign_key "booking_pens", "pen_types"
  add_foreign_key "booking_pens", "pens"
  add_foreign_key "bookings", "booking_statuses"
  add_foreign_key "bookings", "households"
  add_foreign_key "household_concerns", "concerns", column: "concerns_id"
  add_foreign_key "household_concerns", "households"
  add_foreign_key "household_pen_pets", "household_pens"
  add_foreign_key "household_pen_pets", "pets"
  add_foreign_key "household_pen_pets", "rates"
  add_foreign_key "household_pens", "households"
  add_foreign_key "household_pens", "pen_types"
  add_foreign_key "household_people", "households"
  add_foreign_key "household_people", "people"
  add_foreign_key "household_people", "person_types"
  add_foreign_key "immunisations", "pet_types"
  add_foreign_key "pen_types", "pet_types"
  add_foreign_key "pens", "room_types"
  add_foreign_key "pet_foods", "foods"
  add_foreign_key "pet_foods", "measures"
  add_foreign_key "pet_foods", "pets"
  add_foreign_key "pet_foods", "schedules"
  add_foreign_key "pet_health_details", "health_details"
  add_foreign_key "pet_health_details", "pets"
  add_foreign_key "pet_immunisations", "immunisations"
  add_foreign_key "pet_immunisations", "pets"
  add_foreign_key "pet_immunisations", "validities"
  add_foreign_key "pet_issues", "issues", column: "issues_id"
  add_foreign_key "pet_issues", "pets"
  add_foreign_key "pet_medications", "doses"
  add_foreign_key "pet_medications", "medications"
  add_foreign_key "pet_medications", "pets"
  add_foreign_key "pet_medications", "schedules"
  add_foreign_key "pet_sociabilities", "pets"
  add_foreign_key "pet_sociabilities", "sociabilities"
  add_foreign_key "pet_special_needs", "pets"
  add_foreign_key "pet_special_needs", "special_needs"
  add_foreign_key "pets", "breeds"
  add_foreign_key "pets", "colors"
  add_foreign_key "pets", "pet_types"
  add_foreign_key "pets", "sexes"
  add_foreign_key "pets", "sizes"
  add_foreign_key "phones", "people"
  add_foreign_key "phones", "phone_types"
  add_foreign_key "rates", "pet_types"
  add_foreign_key "users", "user_types"
end
