class Coin < ApplicationRecord
  has_many :user_coins
  has_many :users, through: :user_coins

  validates :ticker_symbol, presence: true

  require 'binance_api'
  def self.new_lookup(ticker_symbol)
    rest_client = BinanceAPI::REST.new
    result = rest_client.ticker_24hr(ticker_symbol)
    if result.value[:symbol]
      new(ticker_symbol: ticker_symbol, last_price: result.value[:lastPrice])
    else
      return nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker_symbol: ticker_symbol).first
  end
end
