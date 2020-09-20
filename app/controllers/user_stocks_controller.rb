class UserStocksController < ApplicationController
	def create
		stock = Stock.check_db(params[:ticker], current_user)
		unless stock
			stock = Stock.new_lookup(params[:ticker])
			if stock.save
				@user_stock = UserStock.create(user: current_user, stock: stock)
				flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
				redirect_to my_portfolio_path
			end
		end
	end

	def destroy
		stock = Stock.find(params[:id])
		user_stocks = UserStock.where(user_id: current_user.id, stock_id: stock.id)
		user_stocks.destroy_all
		flash[:notice] = "#{stock.ticker} was successfully removed from portfolio"
		redirect_to my_portfolio_path
	end

	def refresh
		current_user.refresh_stocks
		redirect_to my_portfolio_path
	end
end
