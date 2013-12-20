class TeamstatsController < ApplicationController
  def index
  	redirect_to leagues_path unless current_store.league_id
    @store = Store.find_by_user_id(current_user.id)
    social_challenge
    rankings
    
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
      # flash[:badge] = 1
		elsif new_badges.count > 1
			flash[:badges] = new_badges
      # flash[:badges] = [1,7,10,11,12]
		end
  end

  private

  def social_challenge
    @facebook = Order.where("store_id = #{@store.id}").pluck(:referring_site).grep(/facebook.com/).count
    @twitter = Order.where("store_id = #{@store.id}").pluck(:referring_site).grep(/twitter.com/).count
    @pinterest = Order.where("store_id = #{@store.id}").pluck(:referring_site).grep(/pinterest.com/).count
  end

  def rankings
     
    if Point.pluck(:value) == []
      @rank === 0
    else
    p = Point.where("store_id = #{@store.id}").pluck(:value).sum(:value)
     # setup alert
 
    array = []
      Store.all.each do |s|
        points = Point.where("store_id = #{s.id}").pluck(:value).sum(:value)
        if points == :value
          points = 0
        end
        array << points
      end
    array.sort { |x,y| y <=> x }
    r = Hash[array.map.with_index.to_a]
    @rank = "#{r[p]} out of #{Store.count}"
    binding.pry
    end
  end

end
