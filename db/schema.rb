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

ActiveRecord::Schema.define(version: 2019_06_09_060904) do

  create_table "usd_jpy_s5_candles", force: :cascade do |t|
    t.decimal "close_ask", precision: 8, scale: 5, null: false
    t.decimal "close_bid", precision: 8, scale: 5, null: false
    t.decimal "close_mid", precision: 8, scale: 5, null: false
    t.decimal "high_ask", precision: 8, scale: 5, null: false
    t.decimal "high_bid", precision: 8, scale: 5, null: false
    t.decimal "high_mid", precision: 8, scale: 5, null: false
    t.decimal "low_ask", precision: 8, scale: 5, null: false
    t.decimal "low_bid", precision: 8, scale: 5, null: false
    t.decimal "low_mid", precision: 8, scale: 5, null: false
    t.decimal "open_ask", precision: 8, scale: 5, null: false
    t.decimal "open_bid", precision: 8, scale: 5, null: false
    t.decimal "open_mid", precision: 8, scale: 5, null: false
    t.datetime "time", null: false
    t.integer "volume", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["time"], name: "index_usd_jpy_s5_candles_on_time", unique: true
  end

end
