class AddIndexTimeOnUsdJpyS5Candles < ActiveRecord::Migration[5.2]
  def change
    add_index :usd_jpy_s5_candles, :time, unique: true
  end
end
