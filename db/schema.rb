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

ActiveRecord::Schema.define(version: 2021_01_09_032431) do

  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_bin", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_bin", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_bin", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "eur_jpy_m1_candles", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
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

  create_table "gbp_jpy_m1_candles", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
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

  create_table "resque_schedules", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "cron"
    t.string "class_name"
    t.string "queue"
    t.boolean "enabled", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usd_jpy_m1_candles", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
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

  create_table "usd_jpy_s5_candles", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
