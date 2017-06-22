class SessionsController < ApplicationController
  def new
  end
  def create
  	#render 'new'
  	#debugger
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		session[:user_id] = user.id #put session user_id into session
  		flash[:success] = "you have successfully logged in"
  		redirect_to user_path(user)
  	else
  		flash.now[:danger] = "There is something incorect with your email or password"
  		render 'new'
  	end
  end

  def destroy
  	session[:user_id] = nil
  	flash[:success] = "You have logged"
  	redirect_to root_path
  end
end
