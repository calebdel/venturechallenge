class SessionsController < ApplicationController
  
  def new
    authenticate_store if params[:shop].present?
  end

  def create
    authenticate_store
    
  end
  
  def show
    if response = request.env['omniauth.auth']
      sess = ShopifyAPI::Session.new(params[:shop], response['credentials']['token'])
      session[:shopify] = sess  
      ShopifyAPI::Base.activate_session(sess)
      initialize_webhooks
      Store.find_or_create_by_myshopify_domain(sess.url, access_token: sess.token)
      # current_user = User.find_or_create_by_email(ShopifyAPI::Shop.current_store.email) #you get the idea
      # current_user.password?
      #give him a password if he dont got one
      flash[:notice] = "Logged in"
      redirect_to return_address
    else
      flash[:error] = "Could not log in to Shopify store."
      redirect_to :action => 'new'
    end
  end
  
  def destroy
    session[:shopify] = nil
    flash[:notice] = "Successfully logged out."
    
    redirect_to :action => 'new'
  end
  
  protected

  def initialize_webhooks
    topics = ["orders/create"]
    topics.each do |topic|
      webhook = ShopifyAPI::Webhook.create(format: "json", topic: topic, address: "#{ENV['HOST_URL']}/webhooks/#{topic}")
      # raise "Webhook invalid: (#{topic}) #{webhook.errors}" unless webhook.valid?
    end
  end
  
  def authenticate_store
    if shop_name = sanitize_shop_param(params)
      redirect_to "/auth/shopify?shop=#{shop_name}"
    else
      redirect_to return_address
    end
  end
  
  def return_address
    session[:return_to] || root_url
  end
  
  def sanitize_shop_param(params)
    return unless params[:shop].present?
    name = params[:shop].to_s.strip
    name += '.myshopify.com' if !name.include?("myshopify.com") && !name.include?(".")
    name.sub('https://', '').sub('http://', '')

    u = URI("http://#{name}")
    u.host.ends_with?("myshopify.com") ? u.host : nil
  end
end
