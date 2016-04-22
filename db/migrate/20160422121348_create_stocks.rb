class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :code
      t.string :name
      t.string :market
      t.integer :market_cap
      t.integer :sahres_issued
      t.float :dividend_yield
      t.integer :dividend_one
      t.float :per
      t.float :pbr
      t.float :eps
      t.float :bps
      t.integer :years_high
      t.date :years_high_date
      t.integer :years_low
      t.date :years_low_date

      t.timestamps null: false
    end
  end
end
