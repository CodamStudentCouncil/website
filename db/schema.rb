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

ActiveRecord::Schema[8.0].define(version: 2025_03_18_151528) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "candidate_votes", force: :cascade do |t|
    t.bigint "candidate_id"
    t.text "feedback"
    t.bigint "vote_id"
    t.integer "in_favor", null: false
    t.index ["candidate_id", "in_favor"], name: "index_candidate_votes_on_candidate_id_and_in_favor"
    t.index ["candidate_id"], name: "index_candidate_votes_on_candidate_id"
    t.index ["vote_id"], name: "index_candidate_votes_on_vote_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.string "username", null: false
    t.string "full_name", null: false
    t.string "photo_url"
    t.string "tagline"
    t.text "motivation"
    t.bigint "election_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "focus_area"
    t.index ["election_id"], name: "index_candidates_on_election_id"
    t.index ["username", "election_id"], name: "index_candidates_on_username_and_election_id", unique: true
  end

  create_table "elections", force: :cascade do |t|
    t.date "start_date", default: -> { "now()" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "end_date", null: false
    t.boolean "finalized", default: false, null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.bigint "election_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.index ["election_id"], name: "index_registrations_on_election_id"
    t.index ["username", "election_id"], name: "index_registrations_on_username_and_election_id", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "election_id"
    t.text "feedback"
    t.index ["election_id"], name: "index_votes_on_election_id"
  end

  add_foreign_key "candidates", "elections"
  add_foreign_key "registrations", "elections"
end
