class AddIndexTimeOnUsdJpyM1Candles < ActiveRecord::Migration[5.2]
  def change
    add_index :usd_jpy_m1_candles, :time, unique: true
  end
end
