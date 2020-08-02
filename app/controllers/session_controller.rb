class SessionController < ApplicationController

  skip_before_action :require_login, only: [:new, :create, :omniauth]


    def new
      @user = User.new
    end

    def create
      user = User.find_by_username(params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id 
        redirect_to businesses_path
      else 
        redirect_to '/'
      end
    end


    def omniauth 
      
      user = User.create_from_omniauth(auth)
      if user.valid?
        session[:user_id]= user.id
        redirect_to businesses_path
      else 
        flash[:messages] = user.errors.full_messages.join(" - ")
        redirect_to signup_path
      end
    end 

    def destroy
      
      session.delete(:user_id)
      current_user = nil
      flash[:message] = "You have successfully logged out."
      redirect_to root_path
    
  end

  private 
    def auth 
      request.env['omniauth.auth']
    end 
end
