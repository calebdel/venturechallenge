class HomeController < ApplicationController

  # at all points inside the app, ensure the user is logged in
  # redirect to the login screen if not

  before_filter :ensure_logged_in

  #index is a triage that sends user to either the admin or student section depending on session params

  def index
    redirect_to after_sign_in_path 
  end

  #admin is the admin control panel, which lists all leagues owned by the admin user

  def admin
    @leagues = League.where("admin_id = '#{current_user.id}'")
  end

  #leaderboards is the default view for students
  # in admin view, user can select which league to view via dropdown

  def leaderboards
    # first determine if user is admin or student
    # populate @league and @amind_leagues as necessary
    if session[:shopify]
      redirect_to leagues_path unless current_store.league_id
      @league = League.find(current_store.league_id)
    elsif session[:linkedin]
      @admin_leagues = League.where("admin_id = #{current_user.id}")
      if params[:league]
        @league = League.find(params[:league])
      else  
        @league = League.find_by(admin_id: current_user.id)
      end
    end
    
    # populate array of stores(teams) in current league

    @stores = Store.where("league_id = #{@league.id}")
    @stores.sort!{ |a,b| Point.where("store_id = #{a.id}").sum(:value) <=> Point.where("store_id = #{b.id}").sum(:value) }.reverse!
    

    # the gon. variables are used to pass data to javascript for charts
    gon.numberofTeams = @stores.count

    # populate array of orders for the current league

    @orders = @league.orders

    #figure out daily and weekly winners, [this should probably be a delay job]
    @pointsyesterday = 0
    @pointsthisweek = 0
    @stores.each do |store|
      ptsystrdy = store.points.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight).map(&:value).sum
      if ptsystrdy > @pointsyesterday
        @pointsyesterday = ptsystrdy
        @yesterdaypointswinner = User.find(store.user_id).name
      end

      ptswk = store.points.where(created_at: (Time.now - 7.day)..Time.now).map(&:value).sum
      if ptswk > @pointsthisweek
        @pointsthisweek = ptswk
        @thisweekpointswinner = User.find(store.user_id).name
      end
    end

    #returns a string with the amount of time remaining in the league
    league_countdown 


    # draws charts as long as there is adequate data to do so
    initialize_pointschart unless @orders.count == 0 
  end

  #triages users to the appropriate login

  def after_sign_in_path
     if session[:shopify]
       return leagues_path unless current_store.league_id
       return leaderboards_path
     elsif session[:linkedin]
       return adminpanel_path
     end
  end

  #creates a string with the time remainnig in the league, or returns game over

  def league_countdown
    return @countdown = "Game Over!" if Time.now > @league.end_date

    t = @league.end_date - Time.now

    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    @countdown = "%d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss]
  end

  #used for testing badge alerts

  def fakebadges
    flash[:badges] = [1,2,3,4,5,6,7,8,10,11,12,13,14,15]
    redirect_to leaderboards_path
  end

  
  private

  # sets up data for charts and assigns .gon variables to be passed to js

  def initialize_pointschart

    # array for colors
    gon.color = [] 

    # determine time range of game
    oldestordertime = @orders.maximum("created_at")
    timerange = oldestordertime - @league.start_date

    #set number of time chunks
    if timerange > (86400*13)
      timechunks = 13
    else
      timechunks = timerange / 86400
      timechunks = timechunks.to_i
    end
    
    # setup time range 
    timeinterval = (timerange / timechunks) + 60
    chartlabelarray = [@league.start_date]
    
    #setup label array
    i = 1
    timechunks.times do
      chartlabelarray << (@league.start_date+(timeinterval * i))
      i += 1
    end

    #initialize array data
    gon.data = []

    #scales the opacity of the colored fills depending on the number of players
    opac = 1/(@stores.count).to_f

    #
    @stores.each do |store|
      aggregatepoints = [0]
      i = 1
      (timechunks).times do 
        puts 
        timechunkpoints = store.points.select { |p| p.created_at.between?(chartlabelarray[0],chartlabelarray[i]) }
        aggregatepoints << timechunkpoints.map(&:value).sum
        i += 1
      end
      #generate random color and push into color array
      r = rand(255)
      g = rand(255)
      b = rand(255)
      linecolor = "rgba(#{r},#{g},#{b},1)"
      fillcolor = "rgba(#{r},#{g},#{b},#{opac})"
      gon.data << { 
        "name" => "#{User.find(store.user_id).name}", 
        "linecolor" => linecolor, 
        "fillcolor" => fillcolor,
        "points" => aggregatepoints, 
        "ident" => "store#{store.id}", 
        "totalpts" => Point.where("store_id = #{store.id}").sum(:value)
        }
    end

    #format label array and pass to .gon
    chartlabelarray.map!{|x| x.strftime("%m / %d") }
    gon.labels = chartlabelarray

  end

end
