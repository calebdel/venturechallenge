class SessionsController < ApplicationController

  rescue_from URI::InvalidURIError do |exception|
    flash[:alert] = "Invalid URL, please try again"
    render :new
  end

  def new
  end

  def create
    if shop_name = sanitize_shop_param(params)
      redirect_to "/auth/shopify?shop=#{shop_name}"
    else
      flash[:alert] = "Invalid URL, please try again"
      render :new
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
    name = name.sub('https://', '').sub('http://', '')
    u = URI("http://#{name}")
    u.host.ends_with?("myshopify.com") ? u.host : nil
  end

  def initialize_webhooks
    topics = ["orders/create", "customers/create"]
    topics.each do |topic|
      # check if webhook already exists
      if webhook = ShopifyAPI::Webhook.where(topic: topic).first
        # check if existing webhook address matches the current address
        flash[:alert] = "all webhooks ok"
        unless webhook.address == "#{ENV['HOST_URL']}/webhooks/#{topic}"
         #update it via a put if not
        webhook.update_attributes(address: "#{ENV['HOST_URL']}/webhooks/#{topic}" )
        flash[:alert] = "updated webhook id##{webhook.id}"
        end
      else
        # create the webhook if it does not exist
       webhook = ShopifyAPI::Webhook.create(format: "json", topic: topic, address: "#{ENV['HOST_URL']}/webhooks/#{topic}")
       flash[:alert] = "Created webhook for #{webhook.topic}, id:#{webhook.id}"
      end
    end
  end

end
  