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

ActiveRecord::Schema.define(:version => 20101009060829) do

  create_table "brackets", :force => true do |t|
    t.integer  "tournament_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number_of_rounds"
  end

  add_index "brackets", ["tournament_id"], :name => "index_brackets_on_tournament_id"

  create_table "match_players", :force => true do |t|
    t.integer  "match_id"
    t.integer  "user_id"
    t.integer  "score",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "match_players", ["match_id"], :name => "index_match_players_on_match_id"
  add_index "match_players", ["user_id"], :name => "index_match_players_on_user_id"

  create_table "matches", :force => true do |t|
    t.integer  "winner_id"
    t.datetime "finished_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "preceding_match1_id"
    t.integer  "preceding_match2_id"
    t.datetime "should_end_at"
    t.datetime "should_start_at"
    t.integer  "bracket_id"
    t.integer  "round"
    t.string   "external_game_uri"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.integer  "match_players_count",    :default => 0
    t.integer  "match_length"
    t.datetime "updated_from_server_at"
  end

  add_index "matches", ["bracket_id"], :name => "index_matches_on_bracket_id"
  add_index "matches", ["preceding_match1_id"], :name => "index_matches_on_preceding_match1"
  add_index "matches", ["preceding_match2_id"], :name => "index_matches_on_preceding_match2"
  add_index "matches", ["winner_id"], :name => "index_matches_on_winner_id"

  create_table "registrations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tournament_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed",     :default => false
  end

  add_index "registrations", ["tournament_id"], :name => "index_participants_on_tournament_id"
  add_index "registrations", ["user_id", "tournament_id"], :name => "index_participants_on_user_id_and_tournament_id", :unique => true
  add_index "registrations", ["user_id"], :name => "index_participants_on_user_id"

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "should_start_at"
    t.datetime "should_end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "registrations_count",  :default => 0
    t.integer  "match_length"
    t.integer  "minimum_bracket_size"
    t.integer  "maximum_bracket_size", :default => 0
    t.datetime "started_at"
    t.datetime "ended_at"
  end

  add_index "tournaments", ["should_end_at"], :name => "index_tournaments_on_ends_at"
  add_index "tournaments", ["should_start_at"], :name => "index_tournaments_on_starts_at"

  create_table "users", :force => true do |t|
    t.string   "identifier_url"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",          :default => false
  end

  add_index "users", ["identifier_url"], :name => "index_users_on_identifier_url", :unique => true

end
