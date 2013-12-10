class HomeController < ApplicationController
  
  around_filter :shopify_session, :except => 'welcome'
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login"
  end
  
  def index
    # get 10 products
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})

    # get latest 5 orders
    @orders  = ShopifyAPI::Order.find(:all, :params => {:limit => 5, :order => "created_at DESC" })
  end
  
end

# Mina's Code

# stores = Store.all
# stores.each do |s|
# session = ShopifyAPI::Session.new(s.myshopify_domain, s.access_token)
# ShopifyAPI::Base.activate_session(session)
# orders = ShopifyAPI::Order.find(:all, :params => {:limit => 5, :order => "created_at DESC" })
# p orders
# end