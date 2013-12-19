class TeamstatsController < ApplicationController
  def index
  	redirect_to leagues_path unless current_store.league_id
    @store = Store.find_by_user_id(current_user.id)
    social_challenge
  end


  private


  def social_challenge
    @facebook = Order.where("store_id = #{@store.id}").pluck(:referring_site).grep(/facebook.com/).count
    @twitter = Order.where("store_id = #{@store.id}").pluck(:referring_site).grep(/twitter.com/).count
    @pinterest = Order.where("store_id = #{@store.id}").pluck(:referring_site).grep(/pinterest.com/).count
  end

# def rankings
#   store = Store.all
#   rankings = []
#   store.each do |s|
#   points 

# end

end