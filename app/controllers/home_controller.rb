class HomeController < ApplicationController

  before_filter :ensure_logged_in
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login"
  end
  
  def index
    if session[:shopify]
      redirect_to leagues_path unless current_store.league_id

      @stores = Store.where("league_id = current_store.league_id")

    elsif session[:user_id]
      redirect_to adminpanel_path
    end
  end

  def admin
    @leagues = League.where("admin_id = '#{current_user.id}'")
  end

  def assign_league
    store = Store.find_by_user_id(current_user.id)
    store.league_id = params[:league_id]
    store.save
    redirect_to root_path
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
