class CreateUserCoins < ActiveRecord::Migration[6.1]
  def change
    create_table :user_coins do |t|
      t.references :user, null: false, foreign_key: true
      t.references :coin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
