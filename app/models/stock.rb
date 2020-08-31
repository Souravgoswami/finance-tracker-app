class Stock < ApplicationRecord

	def self.new_lookup(ticker_symbol)
		client = IEX::Api::Client.new(
			endpoint: 'https://sandbox.iexapis.com/v1',
			publishable_token: Rails.application.credentials.iex_client[:publishable_token] || (puts "No publishable token found in credentials.yml.enc"),
			secret_token: Rails.application.credentials.iex_client[:secret_token] || (puts "No secret token found in credentials.yml.enc")
		)

		client.price(ticker_symbol)
	end
end
