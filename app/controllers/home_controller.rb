class HomeController < ApplicationController
  
  around_filter :shopify_session, :except => 'welcome'
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login"
  end
  
  def index
    # get 10 products
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})

    # get all orders
    @orders  = ShopifyAPI::Order.find(:all, :params => {:order => "created_at DESC" }) 
    current_store = Store.find_by myshopify_domain: session[:shopify].url

    ordersum = 0
    @orders.each do |order|
      ordersum += order.total_price.to_f
    end

    current_store.total_orders = ordersum
    current_store.save!

    # one-line temp session:

    # latest_orders = ShopifyAPI::Session.temp("yourshopname.myshopify.com", token) { ShopifyAPI::Order.find(:all) }



    # mina magic

    # @stores = Store.all
    # @stores.each do |s|
    # # session = ShopifyAPI::Session.new(s.myshopify_domain, s.access_token)
    # # ShopifyAPI::Base.activate_session(session)
    # # orders = ShopifyAPI::Order.find(:all, :params => {:order => "created_at DESC" }) 
    # end

  end
  
  def stores

  end

end

# Mina's Code

