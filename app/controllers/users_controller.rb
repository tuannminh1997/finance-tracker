class UsersController < ApplicationController

  def my_portfolio
    @tracked_coins = current_user.coins
    @user = current_user
  end

  def my_friends
    @friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @tracked_coins = @user.coins
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      # @friends = current_user.except_current_user(@friends)
      @friends = @friends.without(current_user)
      if @friends
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Can not find user"
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Invalid friend name or email"
        format.js { render partial: 'users/friend_result' }
      end
    end
  end
end
