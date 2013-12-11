class SessionsController < ApplicationController
  
  def new
    authenticate if params[:shop].present?
  end

  def create
    authenticate
  end
  
  def show
    if response = request.env['omniauth.auth']
      @response =  response # take this out
      sess = ShopifyAPI::cd Session.new(params[:shop], response['credentials']['token'])
      User.find_or_create_by_name(response[''])
      Store.find_or_create_by_myshopify_domain(sess.url, access_token: sess.token)
      session[:shopify] = sess        
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
  
  def authenticate
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
