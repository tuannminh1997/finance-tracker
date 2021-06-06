class User < ApplicationRecord
  has_many :user_coins
  has_many :coins, through: :user_coins
  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def coin_already_tracked?(ticker_symbol)
    coin = Coin.check_db(ticker_symbol)
    return false unless coin

    coins.where(id: coin.id).exists?
  end

  def under_coin_limit
    coins.count < 10
  end

  def can_track_coin?(ticker_symbol)
    under_coin_limit && !coin_already_tracked?(ticker_symbol)
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name

    "Guest"
  end

  def self.search(param)
    param.strip!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back

    to_send_back
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end

  def except_current_user(users)
    users.reject { |user| user.id == id }
  end

  def not_friends_with?(id_of_friend)
    !friends.where(id: id_of_friend).exists?
  end
end
