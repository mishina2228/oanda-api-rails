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

ActiveRecord::Schema.define(version: 2019_06_17_083259) do

  create_table "eur_jpy_m1_candles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
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
    t.index ["time"], name: "index_eur_jpy_m1_candles_on_time", unique: true
  end

  create_table "gbp_jpy_m1_candles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
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
    t.index ["time"], name: "index_gbp_jpy_m1_candles_on_time", unique: true
  end

  create_table "resque_schedules", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "cron"
    t.string "class_name"
    t.string "queue"
    t.boolean "enabled", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usd_jpy_m1_candles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
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
    t.index ["time"], name: "index_usd_jpy_m1_candles_on_time", unique: true
  end

  create_table "usd_jpy_s5_candles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
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
