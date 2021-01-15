class ApplicationController < ActionController::Base
  
  helper_method :current_user, :logged_in?, :require_user

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      @current_user = nil
      session[:user_id] = nil
      redirect_to root_path
      return
    end
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform this action."
      redirect_to login_path
    end
  end

end
