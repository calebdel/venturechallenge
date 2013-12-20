class TeamstatsController < ApplicationController
  def index
  	redirect_to leagues_path unless current_store.league_id
    @store = Store.find_by_user_id(current_user.id)
    social_challenge
    rankings
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

    array = []
      Store.all.each do |s|
        points = Point.where("store_id = #{s.id}").pluck(:value).sum(:value)
        array << points 
        end
      
    
    r = Hash[array.map.with_index.to_a]
    @rank = "#{r[p] + 1} out of #{Store.count}"
    end
  
  end


end