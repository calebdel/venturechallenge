class HomeController < ApplicationController
  
  around_filter :shopify_session, :except => 'welcome'
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login"
  end
  
  def index
    # get 10 products
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})


    # latest_orders = ShopifyAPI::Session.temp("yourshopname.myshopify.com", token) { ShopifyAPI::Order.find(:all) }

    refresh_store_data
  end
  

def refresh_store_data
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

# Mina's Code

