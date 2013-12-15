class League < ActiveRecord::Base
	belongs_to :user
	has_many :stores

	validate :start_date_not_in_the_past

	validate :end_date_not_before_start_date


	def start_date_not_in_the_past
		if start_date < Time.now
			errors.add(:end_date, "Start Date must be in the future")
		end
	end

	def end_date_not_before_start_date
		if start_date > end_date
     errors.add(:end_date, "End date cannot be before Start Date")
 		end
 	end


end
