class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  before_save :generate_username_if_empty

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  validates :username, uniqueness: { case_sensitive: false }, length: { maximum: 64 }

  def stock_already_tracked?(ticker_symbol)
    stocks.where(ticker: ticker_symbol.upcase).exists?
  end

  def under_stock_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol.upcase)
  end

  private
  def generate_username_if_empty
    unless username
      counter = -1

      gen_username = "#{first_name}#{last_name}"
      gen_username = "#{first_name}#{last_name}#{counter += 1}" while User.where(username: gen_username).exists?

      self.username = gen_username
    end
  end

  def truncate_username
    # if username.length > 64
    # end
  end
end
