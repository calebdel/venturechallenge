class SessionsController < ApplicationController

  def new
  end

  def admin_new
  end

  def create
    if params[:url]
    shop_name = sanitize_shop_param(params)
    redirect_to "/auth/shopify?shop=#{shop_name}"
    else
      redirect_to login_path, notice: "Invalid URL, please try again"
    end
  end

  def destroy
    session[:shopify] = nil
    session[:linkedin] = nil
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end

  def authorize

    auth_info = request.env['omniauth.auth']
    sess = ShopifyAPI::Session.new(params[:shop], auth_info['credentials']['token'])
    session[:shopify] = sess 
    ShopifyAPI::Base.activate_session(sess)
    shop = ShopifyAPI::Shop.current
    user = User.find_or_create_by_url(sess.url, shopify_token: sess.token, name:shop.name, email:shop.email)

    store = Store.find_or_create_by_user_id(user.id)

    store.save

    initialize_webhooks
    redirect_to root_url, :notice => "Logged in as #{user.name}"
  end

  def admin_authorize
    auth_info = request.env['omniauth.auth']
    
    session[:linkedin] = auth_info['credentials']['token']

    user = User.find_or_create_by_linkedin_uid(auth_info['uid'], name:auth_info['info']['name'], phone:auth_info['info']['phone'], email:auth_info['info']['email'], linkedin_token:auth_info['credentials']['token'])
    
    redirect_to adminpanel_path, notice: "Logged in as #{user.name}"
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

  def initialize_webhooks
    topics = ["orders/create", "customers/create"]
    topics.each do |topic|
      if webhook = ShopifyAPI::Webhook.where(topic: topic).first
        unless webhook.address == "#{ENV['HOST_URL']}/webhooks/#{topic}"
         #update it via a put
        webhook.update_attributes(address: "#{ENV['HOST_URL']}/webhooks/#{topic}" )
        end
      else
       ShopifyAPI::Webhook.create(format: "json", topic: topic, address: "#{ENV['HOST_URL']}/webhooks/#{topic}")
      end
    end
  end

end
  