class User < ActiveRecord::Base
	has_secure_password 
  validates :name, :email, presence: true
  validates :email, uniqueness: true

	has_one :store

	has_many :leagues
end
