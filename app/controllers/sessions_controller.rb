class SessionsController < ApplicationController

  def new
  end

  def admin_new
  end

  def create
    if params[:url]

    shop_name = sanitize_shop_param(params)
    redirect_to "/auth/shopify?shop=#{shop_name}"

    elsif params[:email]

    user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to adminpanel_path #but probably somewhere else
      else
        redirect_to "http://www.google.com"
      end
    end
  end

  

  def destroy
    session[:shopify] = nil
    session[:user_id] = nil
    flash[:notice] = "Successfully logged out."
    redirect_to root_path
  end

  def authorize
    omniauth_shit = request.env['omniauth.auth']
    sess = ShopifyAPI::Session.new(params[:shop], omniauth_shit['credentials']['token']) #why is the shop url still in the params of the callback?
    session[:shopify] = sess 
    ShopifyAPI::Base.activate_session(sess) # is this necessary?? we dunno

    user = User.find_or_create_by_url(sess.url, token: sess.token, name:sess.url, password:"000000", password_confirmation:"000000")

    store = Store.find_or_create_by_user_id(user.id)

    initialize_webhooks

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

  def initialize_webhooks
    topics = ["orders/create"]
    topics.each do |topic|
      webhook = ShopifyAPI::Webhook.create(format: "json", topic: topic, address: "#{ENV['HOST_URL']}/webhooks/#{topic}")
          binding.pry 

      raise "Webhook invalid: (#{topic}) #{webhook.errors}" unless webhook.valid?
    end
  end

end

  
