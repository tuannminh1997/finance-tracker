class CoinsController < ApplicationController

  def search
    if params[:coin].present?
      @coin = Coin.new_lookup(params[:coin])
      if @coin
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid symbol to search"
          format.js { render partial: 'users/result' }
        end
      end

    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a symbol to search"
        format.js { render partial: 'users/result' }
      end
    end

  end
end
