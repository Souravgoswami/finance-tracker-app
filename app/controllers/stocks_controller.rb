class StocksController < ApplicationController
	def search
		if params[:stock].present?
			@ticker_name = params[:stock].upcase
			@stock = Stock.new_lookup(@ticker_name)
			@tracked_stocks = current_user.stocks
			@user = current_user

			if @stock
				respond_to do |f|
					f.js { render partial: 'users/result' }
				end
			else
				respond_to do |f|
					# flash[:alert] =
					f.js { render partial: 'users/result' }
				end
			end
		else
			respond_to do |f|
				flash[:alert] = 'Please enter a symbol to search!'
				f.js { render partial: 'users/result' }
			end
		end
	end
end
