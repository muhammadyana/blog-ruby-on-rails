class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user, :logged_in?

  # def current_user
  # 	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end
  def logged_in?
  	#return true if there is current user and retrn false if no have current user
  	!!current_user
  end

  def require_user
  	if !logged_in?
  		flash[:danger] = "You must logg in to perform the action"
  		redirect_to root_path
  	end
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name])
    # devise_parameter_sanitizer.for(:account_update) << :name
  end
end
