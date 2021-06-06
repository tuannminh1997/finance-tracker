class UserCoinsController < ApplicationController

  def create
    coin = Coin.check_db(params[:ticker_symbol])
    if coin.blank?
      coin = Coin.new_lookup(params[:ticker_symbol])
      coin.save
    end
    @user_coin = UserCoin.create(user: current_user, coin: coin)
    flash[:notice] = "Coin #{coin.ticker_symbol} was successfully added to your portforlio"
    redirect_to my_portfolio_path
  end

  def destroy
    coin = Coin.find(params[:id])
    user_coin = UserCoin.where(user_id: current_user.id, coin_id: coin.id)
    user_coin.destroy_all
    flash[:notice] = "#{coin.ticker_symbol} was successfully removed from you portfolio"
    redirect_to my_portfolio_path
  end
end
