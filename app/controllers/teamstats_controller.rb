class TeamstatsController < ApplicationController
  def index
  	redirect_to leagues_path unless current_store.league_id
    @store = Store.find_by_user_id(current_user.id)
    social_challenge
    store_stats
    rankings
    current_points
    
    # if the store already has some badges, cache them
    # if they don't, setup an empty array to compare to

   	# if @store.badge_array
    # 	old_array = @store.badge_array.scan(/\d+/).map(&:to_i)
   	# else
    # 	old_array = []
    # end

    # save the current collection of badges to the db
   	
  #  	@store.badge_array = @store.badges.map(&:id).to_s
		# @store.save

		# determine which badges are newly won

   	# new_badges = @store.badge_array.scan(/\d+/).map(&:to_i) - old_array

   	# setup alert

  #  	if new_badges.count == 1
  #  		flash[:badge] = new_badges.first
  #     # flash[:badge] = 1
		# elsif new_badges.count > 1
		# 	flash[:badges] = new_badges
  #     # flash[:badges] = [1,7,10,11,12]
		# end
  end

  private

  def social_challenge
    @facebook = Order.where("store_id = #{@store.id}").pluck(:referring_site).grep(/facebook.com/).count
    @twitter = Order.where("store_id = #{@store.id}").pluck(:referring_site).grep(/twitter.com/).count
    @pinterest = Order.where("store_id = #{@store.id}").pluck(:referring_site).grep(/pinterest.com/).count
  end

  def rankings
    league = League.find(current_store.league_id)
    stores = Store.where("league_id = #{league.id}")

    if Point.pluck(:value).inject{|sum,x| sum + x } == 0
      @rank = 0
    else
    p = Point.where("store_id = #{@store.id}" ).pluck(:value).sum(:value)
 
    array = []
      stores.all.each do |s|
        points = Point.where("store_id = #{s.id}").pluck(:value).sum(:value)
        if points == :value
          points = 0
        end
        array << points
      end
    array.sort! { |x,y| y <=> x }
    r = Hash[array.each_with_index.map { |value, index| [index, value] }]
    @rank = "#{r.index(p) + 1} out of #{Store.count}"
    end
  end

  def store_stats
    @totalsales = Order.where("store_id = #{@store.id}").pluck(:subtotal_price).sum(:value)
    @totalcustomers = Customer.where("store_id = #{@store.id}").count
      if @totalcustomers == 0 
        @arpu = 0
      else
        @arpu = (@totalsales / @totalcustomers)
      end

  end

  def current_points
    @totalpoints = Point.where("store_id = #{@store.id}").pluck(:value).sum(:value)
    @salespoints = Point.where("store_id = #{@store.id} AND kind_id = 2").sum(:value)
    @customerpoints = Point.where("store_id = #{@store.id} AND kind_id = 1").sum(:value)
    @facebookpoints = Point.where("store_id = #{@store.id} AND kind_id = 3").sum(:value)
    @twitterpoints = Point.where("store_id = #{@store.id} AND kind_id = 4").sum(:value)
    @pinterestpoints = Point.where("store_id = #{@store.id} AND kind_id = 5").sum(:value)
    @instagrampoints = Point.where("store_id = #{@store.id} AND kind_id = 6").sum(:value)

    gon.one = @salespoints
    gon.two = @customerpoints
    gon.three = @facebookpoints
    gon.four = @twitterpoints
    gon.five = @pinterestpoints
    gon.six = @instagrampoints


  end


end
