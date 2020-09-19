class User < ApplicationRecord
	has_many :user_stocks
	has_many :stocks, through: :user_stocks
	has_many :friendships
	has_many :friends, through: :friendships

	before_save :generate_username_if_empty
	before_save :downcase_username

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :validatable

	validates :username, uniqueness: { case_sensitive: false }, length: { maximum: 64 }, on: :create
	validate :username_valid?, on: :create

	validates :first_name, length: { minimum: 2, maximum: 32 }
	validates :last_name, length: { minimum: 2, maximum: 32 }

	def stock_already_tracked?(ticker_symbol)
		stocks.where(ticker: ticker_symbol.upcase).exists?
	end

	def under_stock_limit?
		stocks.count < 10
	end

	def can_track_stock?(ticker_symbol)
		under_stock_limit? && !stock_already_tracked?(ticker_symbol.upcase)
	end

	def self.search(str)
		User.where('LOWER(username) LIKE ?', "%#{str.downcase}%").+(
			User.where('LOWER(email) LIKE ?', "%#{str.downcase}%")
		).uniq
	end


	def except_current_user(users)
		id = self.id
		users.reject { |u| u.id == id }
	end

	def not_friends_with?(user_id)
		!self.friends.any? { |f| f.id == user_id }
	end

	private
	def generate_username_if_empty
		unless username
			counter = -1

			gen_username = "#{first_name}#{last_name}"
			similar_names = User.where('username LIKE ?', "#{gen_username}%").map(&:username)

			while similar_names.include?(gen_username)

				gen_username = if counter < 20_000
					"#{first_name}#{last_name}#{counter += 1}"
				else
					"#{first_name}#{last_name}#{counter += 1}#{rand(1..1000)}"
				end
			end

			self.username = gen_username.downcase
		end
	end

	def downcase_username
		username.tap(&:downcase!)
	end

	def username_valid?
		errors.add(:username, 'is not valid') if username && username[/[^a-z0-9_]/i]
	end
end
