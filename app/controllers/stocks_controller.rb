class StocksController < ApplicationController
	def search
		if params[:stock].present?
			@stock = Stock.new_lookup(params[:stock])
			if @stock
				respond_to do |f|
					f.js { render partial: 'users/result' }
				end
			else
				respond_to do |f|
					flash[:alert] = "#{params[:stock]} is not a valid symbol!"
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
