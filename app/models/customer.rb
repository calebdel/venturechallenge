class Customer < ActiveRecord::Base
	belongs_to :league
	belongs_to :store
end
