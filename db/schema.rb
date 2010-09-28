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

ActiveRecord::Schema.define(:version => 20100927231549) do

  create_table "brackets", :force => true do |t|
    t.integer  "tournament_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number_of_rounds"
  end

  add_index "brackets", ["tournament_id"], :name => "index_brackets_on_tournament_id"

  create_table "matches", :force => true do |t|
    t.integer  "participant1_id"
    t.integer  "participant2_id"
    t.integer  "winner_id"
    t.datetime "finished_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "preceding_match1_id"
    t.integer  "preceding_match2_id"
    t.datetime "ends_at"
    t.datetime "starts_at"
    t.integer  "bracket_id"
    t.integer  "round"
  end

  add_index "matches", ["bracket_id"], :name => "index_matches_on_bracket_id"
  add_index "matches", ["participant1_id"], :name => "index_matches_on_participant1_id"
  add_index "matches", ["participant2_id"], :name => "index_matches_on_participant2_id"
  add_index "matches", ["preceding_match1_id"], :name => "index_matches_on_preceding_match1"
  add_index "matches", ["preceding_match2_id"], :name => "index_matches_on_preceding_match2"
  add_index "matches", ["winner_id"], :name => "index_matches_on_winner_id"

  create_table "participants", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tournament_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participants", ["tournament_id"], :name => "index_participants_on_tournament_id"
  add_index "participants", ["user_id", "tournament_id"], :name => "index_participants_on_user_id_and_tournament_id", :unique => true
  add_index "participants", ["user_id"], :name => "index_participants_on_user_id"

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone"
    t.integer  "participants_count",   :default => 0
    t.integer  "match_length"
    t.integer  "minimum_bracket_size"
  end

  add_index "tournaments", ["ends_at"], :name => "index_tournaments_on_ends_at"
  add_index "tournaments", ["starts_at"], :name => "index_tournaments_on_starts_at"

  create_table "users", :force => true do |t|
    t.string   "identifier_url"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["identifier_url"], :name => "index_users_on_identifier_url", :unique => true

end
