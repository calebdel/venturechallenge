class TeamstatsController < ApplicationController
  def index
    @store = Store.find_by_user_id(current_user.id)
  end


end
