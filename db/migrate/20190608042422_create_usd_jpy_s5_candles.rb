class CreateUsdJpyS5Candles < ActiveRecord::Migration[5.2]
  def change
    create_table :usd_jpy_s5_candles do |t|
      t.decimal :close_ask, precision: 8, scale: 5, null: false
      t.decimal :close_bid, precision: 8, scale: 5, null: false
      t.decimal :close_mid, precision: 8, scale: 5, null: false
      t.decimal :high_ask, precision: 8, scale: 5, null: false
      t.decimal :high_bid, precision: 8, scale: 5, null: false
      t.decimal :high_mid, precision: 8, scale: 5, null: false
      t.decimal :low_ask, precision: 8, scale: 5, null: false
      t.decimal :low_bid, precision: 8, scale: 5, null: false
      t.decimal :low_mid, precision: 8, scale: 5, null: false
      t.decimal :open_ask, precision: 8, scale: 5, null: false
      t.decimal :open_bid, precision: 8, scale: 5, null: false
      t.decimal :open_mid, precision: 8, scale: 5, null: false
      t.datetime :time, null: false
      t.integer :volume, null: false

      t.timestamps null: false
    end
  end
end
