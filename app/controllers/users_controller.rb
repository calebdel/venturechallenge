class UsersController < ApplicationController
  
  #note that this controller is only used for admin user creation
  #shopify user creation 

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      session[:user_id] = @user.id
  		redirect_to root_url
  	else
  		render :new
  	end
  end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation, :url, :token)
  end

end
