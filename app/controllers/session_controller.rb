class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(id: params[:id])
    if user && user.authenticate(password: params[:password])
      session[:user_id] = user.id 
      redirect_to user_path(user)
    else 
      redirect_to signup_path
    end
  end

  def destroy
    if logged_in?
      session.destroy 
      redirect_to rooth_path
    end 
  end

  def omniauth 
    
    user = User.create_from_omniauth(auth)
    if user.valid?
      session[:user_id]= user.id
      redirect_to user_path(user)
    else 
      flash[:messages] = user.errors.full_messages.join(" - ")
      redirect_to signup_path
    end
  end 

  private 
    def auth 
      request.env['omniauth.auth']
    end 
end