class User < ActiveRecord::Base
  validates :name, :email, presence: true

	has_one :store

	has_many :leagues
end
