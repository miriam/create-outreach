# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  layout 'base'
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  def require_logged_in
    if !logged_in?
      redirect_to landing_page and return false
    end
    return true
  end

  def logged_in?
    !!session[:user_id]
  end

  def landing_page
    if current_user
      events_path
    else
      pages_path
    end
  end

  def current_user
    if session[:user_id].nil?
      @user ||= nil
    else
      @user ||= User.find_by_id(session[:user_id])
    end
  end

end
