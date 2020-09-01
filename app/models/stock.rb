class Stock < ApplicationRecord
	has_many :user_stocks
	has_many :users, through: :user_stocks
	validates :name, :ticker, presence: true

	before_save :upcase_ticker

	def upcase_ticker
		ticker.upcase!
	end

	def self.new_lookup(ticker_symbol)
		client = IEX::Api::Client.new(
			endpoint: 'https://sandbox.iexapis.com/v1',
			publishable_token: Rails.application.credentials.iex_client[:publishable_token] || (puts "No publishable token found in credentials.yml.enc"),
			secret_token: Rails.application.credentials.iex_client[:secret_token] || (puts "No secret token found in credentials.yml.enc")
		)

		begin
			new(
				ticker: ticker_symbol,
				name: client.company(ticker_symbol).company_name,
				last_price: client.price(ticker_symbol)
			)
		rescue Exception
			nil
		end
	end

	def self.check_db(ticker_symbol)
		where(ticker: ticker_symbol.upcase).any?
	end
end
