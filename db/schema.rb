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

ActiveRecord::Schema[7.0].define(version: 2023_06_04_001802) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "opened_at"
    t.time "closed_at"
    t.index ["name"], name: "index_rooms_on_name", unique: true
  end

  create_table "schedules", force: :cascade do |t|
    t.string "title"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "owner_id"
    t.string "owner_name"
    t.index ["owner_id"], name: "index_schedules_on_owner_id"
    t.index ["room_id"], name: "index_schedules_on_room_id"
  end

  add_foreign_key "schedules", "rooms"
end
