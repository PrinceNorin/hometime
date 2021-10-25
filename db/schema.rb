# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_25_083017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guests", force: :cascade do |t|
    t.string "email", null: false
    t.text "phone"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_guests_on_email", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "guest_id"
    t.string "code", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "number_of_nights", default: 0
    t.integer "number_of_guests", default: 0
    t.integer "number_of_adults", default: 0
    t.integer "number_of_children", default: 0
    t.integer "number_of_infants", default: 0
    t.integer "payout_amount", default: 0
    t.integer "security_amount", default: 0
    t.integer "total_amount", default: 0
    t.string "currency"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_reservations_on_code", unique: true
    t.index ["end_date"], name: "index_reservations_on_end_date"
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
    t.index ["start_date"], name: "index_reservations_on_start_date"
    t.index ["status"], name: "index_reservations_on_status"
  end

end
