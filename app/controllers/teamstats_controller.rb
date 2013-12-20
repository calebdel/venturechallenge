class TeamstatsController < ApplicationController
  def index
  	redirect_to leagues_path unless current_store.league_id
    @store = Store.find_by_user_id(current_user.id)

    # if the store already has some badges, cache them
    # if they don't, setup an empty array to compare to

   	if @store.badge_array
    	old_array = @store.badge_array.scan(/\d+/).map(&:to_i)
   	else
    	old_array = []
    end

    # save the current collection of badges to the db
   	
   	@store.badge_array = @store.badges.map(&:id).to_s
		@store.save

		# determine which badges are newly won

   	new_badges = @store.badge_array.scan(/\d+/).map(&:to_i) - old_array

   	# setup alert


   	if new_badges.count == 1
   		flash[:badge] = new_badges.first
		elsif new_badges.count > 1
			flash[:badges] = new_badges
		end
  end
end
