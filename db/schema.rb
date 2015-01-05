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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150104202926) do

  create_table "boards", force: :cascade do |t|
    t.string   "rows"
    t.string   "columns"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "board_id"
  end

  add_index "games", ["board_id"], name: "index_games_on_board_id"

  create_table "guesses", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "guess_value"
    t.boolean  "is_hit"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "guesses", ["game_id"], name: "index_guesses_on_game_id"

  create_table "ship_placements", force: :cascade do |t|
    t.integer  "ship_id"
    t.integer  "game_id"
    t.integer  "top_left_value"
    t.string   "orientation"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "hits"
  end

  add_index "ship_placements", ["game_id"], name: "index_ship_placements_on_game_id"
  add_index "ship_placements", ["ship_id"], name: "index_ship_placements_on_ship_id"

  create_table "ships", force: :cascade do |t|
    t.string   "name"
    t.integer  "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
