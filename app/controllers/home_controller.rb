class HomeController < ApplicationController

  before_filter :ensure_logged_in


  def index
    redirect_to after_sign_in_path 
   end

  def admin
    @leagues = League.where("admin_id = '#{current_user.id}'")
  end

  def leaderboards

    # get all stores in current league
    @league = League.find(current_store.league_id)
    @stores = Store.where("league_id = #{@league.id}")
    @stores.each do |store|
      store.total_orders = Order.where("store_id = #{store.id}").sum(:subtotal_price)
    end
    @stores.sort!{ |a,b| a.total_orders <=> b.total_orders }.reverse!
    @orders = @league.orders
    @points = Point.all

    gon.numberofTeams = @stores.count

    initialize_pointschart
    
  end

  def after_sign_in_path
     if session[:shopify]
       return leagues_path unless current_store.league_id
       return leaderboards_path
     elsif session[:linkedin]
       return adminpanel_path
     end
  end
  

  private

  def initialize_pointschart

    # array for colors
    gon.color = [] 

    #set number of time chunks
    timechunks = 10

    # setup time range 
    oldestordertime = @orders.maximum("created_at")
    timerange = oldestordertime - @league.start_date
    timeinterval = timerange / timechunks
    chartlabelarray = [@league.start_date]
    
    #setup label array
    i = 1
    (timechunks-1).times do
      chartlabelarray << (@league.start_date+(timeinterval * i))
      i += 1
    end

    #initialize array data
    gon.data = []

    opac = 1/(@stores.count).to_f

    @stores.each do |store|
      #create array of aggregate points within the time chunk
      aggregatepoints = [0]
      i = 1
      (timechunks-1).times do 
        timechunkpoints = store.points.select { |p| p.created_at.between?(chartlabelarray[0],chartlabelarray[i]) }
        aggregatepoints << timechunkpoints.map(&:value).sum
        i += 1
      end
      #generate random color and push into color array
      storecolor = "rgba(#{rand(255)},#{rand(255)},#{rand(255)},#{opac})"
      gon.data << { 
        "name" => "#{User.find(store.user_id).name}", 
        "color" => storecolor, 
        "points" => aggregatepoints, 
        "ident" => "store#{store.id}", 
        "totalpts" => Point.where("store_id = #{store.id}").sum(:value)
        }
    end

    #format label array and pass to .gon
    chartlabelarray.map!{|x| x.strftime("%m / %d") }
    gon.labels = chartlabelarray

  end

  def initialize_barchart
    
    #initialize array data
    gon.bardata = []

    gon.bardata << gon.data.pluck("name")



  end


end
