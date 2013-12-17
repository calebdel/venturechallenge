class HomeController < ApplicationController

  before_filter :ensure_logged_in

  
  
  def index
    redirect_to after_sign_in_path
  end

  def admin
    @leagues = League.where("admin_id = '#{current_user.id}'")
  end

  def leaderboards
    @stores = Store.where("league_id = #{current_store.league_id}")

    gon.numberofTeams = @stores.count

    gon.color = []
    gon.orders = []

    @stores.each do |st|
      gon.col = "rgba(#{rand(255)},#{rand(255)},#{rand(255)},0.3)"
      gon.color << gon.col
      gon.ord = Order.where("store_id = #{st.id}").map(&:subtotal_price)
      gon.orders << gon.ord
    end
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
