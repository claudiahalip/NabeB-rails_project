class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :require_login
  
  

  def route_not_found
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path 
    end
  end

end


