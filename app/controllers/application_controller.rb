class ApplicationController < ActionController::Base
  protect_from_forgery

  # Ask shop to authorize app again if additional permissions are required
   rescue_from ActiveResource::ForbiddenAccess do
     clear_sessions
     flash[:notice] = "This app requires additional permissions, please log in and authorize it."
     redirect_to controller: :sessions, action: :create
   end

	private

  def current_user

  	# first check to see if there is a Shopify-connected user currently active:
  	@current_user ||= User.find_by_url(session[:shopify].url) if session[:shopify]
    
  	# if not, check to see if there is an admin user active:
    @current_user ||= User.find_by_linkedin_token(session[:linkedin]) if session[:linkedin]

    #return current user if available, otherwise return nil
    return @current_user

  end

  def current_store

    Store.find_by_user_id(current_user.id)

  end

  def clear_sessions
    session[:shopify] = nil
    session[:linkedin] = nil
  end


  def ensure_logged_in
    unless current_user #if no current user, nil is returned, triggering a redirect to the login screen
      flash[:alert] = "Please log in"
      clear_sessions
      redirect_to login_path
    end
  end

  helper_method :current_user
  helper_method :current_store
  helper_method :ensure_logged_in

end
