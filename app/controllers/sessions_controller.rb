class SessionsController < ApplicationController

  def new
  end

  def create
    if params[:url]

    shop_name = sanitize_shop_param(params)
    redirect_to "/auth/shopify?shop=#{shop_name}"

    elsif params[:email]

    user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to adminpanel_url #but probably somewhere else
      else
        redirect_to "http://www.google.com"
      end
    end
  end

  def admin_new
  end

  def authorize
    omniauth_shit = request.env['omniauth.auth']
    sess = ShopifyAPI::Session.new(params[:shop], omniauth_shit['credentials']['token']) #why is the shop url still in the params of the callback?
    session[:shopify] = sess 
    ShopifyAPI::Base.activate_session(sess) # is this necessary?? we dunno

    user = User.find_or_create_by_url(sess.url, token: sess.token)

    store = Store.find_or_create_by_user_id(user.id)

    redirect_to root_url, :notice => "You got logged the FUCK in"

  end

  private


    
  


  
  def sanitize_shop_param(params)
    return unless params[:url].present?
    name = params[:url].to_s.strip
    name += '.myshopify.com' if !name.include?("myshopify.com") && !name.include?(".")
    name.sub('https://', '').sub('http://', '')

    u = URI("http://#{name}")
    u.host.ends_with?("myshopify.com") ? u.host : nil
  end

end
  
#   def new
#     authenticate_store if params[:shop].present?
#   end

#   def create
#     authenticate_store
    
#   end
  
#   def show
#     if response = request.env['omniauth.auth']
#       sess = ShopifyAPI::Session.new(params[:shop], response['credentials']['token'])
#       session[:shopify] = sess  
#       ShopifyAPI::Base.activate_session(sess)
      
#       initialize_webhooks
      
#       if User.find_or_create_by_name3(sess.url, access_token: sess.token)
    


#       # current_user = User.find_or_create_by_email(ShopifyAPI::Shop.current_store.email) #you get the idea
#       # current_user.password?
#       # give him a password if he dont got one
      
#         flash[:notice] = "Logged in"
#         redirect_back_or_to root_path

#       else
#         flash[:error] = "Could not log in to Shopify store."
#         redirect_to :action => 'new'
#       end

#     else
#       flash[:error] = "Could not log in to Shopify store."
#       redirect_to :action => 'new'
#     end
#   end
  
#   def destroy
#     session[:shopify] = nil
#     flash[:notice] = "Successfully logged out."
    
#     redirect_to :action => 'new'
#   end
  
#   protected

#   def initialize_webhooks
#     topics = ["orders/create"]
#     topics.each do |topic|
#       webhook = ShopifyAPI::Webhook.create(format: "json", topic: topic, address: "#{ENV['HOST_URL']}/webhooks/#{topic}")
#       # raise "Webhook invalid: (#{topic}) #{webhook.errors}" unless webhook.valid?
#     end
#   end
  
#   def authenticate_store
#     if shop_name = sanitize_shop_param(params)
#       redirect_to "/auth/shopify?shop=#{shop_name}"
#     else
#       redirect_to return_address
#     end
#   end

  
#   def sanitize_shop_param(params)
#     return unless params[:shop].present?
#     name = params[:shop].to_s.strip
#     name += '.myshopify.com' if !name.include?("myshopify.com") && !name.include?(".")
#     name.sub('https://', '').sub('http://', '')

#     u = URI("http://#{name}")
#     u.host.ends_with?("myshopify.com") ? u.host : nil
#   end
# end
