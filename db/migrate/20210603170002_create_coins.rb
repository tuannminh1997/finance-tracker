class CreateCoins < ActiveRecord::Migration[6.1]
  def change
    create_table :coins do |t|
      t.string :ticker_symbol
      t.decimal :last_price
      t.timestamps
    end
  end
end
