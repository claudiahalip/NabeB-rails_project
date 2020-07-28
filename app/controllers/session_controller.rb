class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by(id: params[:id])
    if user && user.authenticate(password: params[:password])
      session[:user_id] = user.id 
      redirect_to users_path
    else 
      redirect_to new_user_path
  end

  def destroy
  end

  def omniauth 
    
    user = User.create_from_omniauth(auth)
    if user.valid?
      session[:user_id]= user.id
      redirect_to users_path
    else 
      flash[:messages] = user.errors.full_messages.join(" - ")
      redirect_to new_user_path
    end
  end 

  private 
    def auth 
      request.env['omniauth.auth']
    end 
end
