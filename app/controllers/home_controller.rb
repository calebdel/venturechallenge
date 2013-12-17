class HomeController < ApplicationController

  before_filter :ensure_logged_in

  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login"
  end
  
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
    @orders = @league.orders
    @points = Point.all

    gon.numberofTeams = @stores.count
    gon.color = [] # array for colors

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

    gon.points = []

    @stores.each do |store|
      #generate random color and push into color array
      storecolor = "rgba(#{rand(255)},#{rand(255)},#{rand(255)},0.4)"
      gon.color << storecolor
      
      #create array of aggregate points
      aggregatepoints = [0]
      i = 1
      (timechunks-1).times do 
        timechunkpoints = store.points.select { |p| p.created_at.between?(chartlabelarray[0],chartlabelarray[i]) }
        aggregatepoints << timechunkpoints.map(&:value).sum
        i += 1
      end
      gon.points << aggregatepoints
    end

    #format label array and pass to .gon
    chartlabelarray.map!{|x| x.strftime("%m / %d") }
    gon.labels = chartlabelarray
  end

  def after_sign_in_path
     if session[:shopify]
       return leagues_path unless current_store.league_id
       return leaderboards_path
     elsif session[:linkedin]
       return tasksadmins_path
     end
  end
  

  private

  def refresh_store_data # probably not necessary
    @stores = Store.all
  
    @stores.each do |s|
    session = ShopifyAPI::Session.new(s.myshopify_domain, s.access_token)
    ShopifyAPI::Base.activate_session(session)


      @orders  = ShopifyAPI::Order.find(:all, :params => {:order => "created_at DESC" }) 

      @customers  = ShopifyAPI::Customer.find(:all, :params => {:order => "created_at DESC" }) 

      s.order_count = @orders.count
      s.customer_count = @customers.count
      ordersum = 0
      @orders.each do |order|
        ordersum += order.total_price.to_f
      end

      s.total_orders = ordersum
      s.save! 

    end
  end


end
