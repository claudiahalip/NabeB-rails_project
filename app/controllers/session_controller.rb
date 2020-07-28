class SessionController < ApplicationController
  def login
    #user = User.find_by(id: params[:id])
  end

  def logout
  end

  def omniauth 
    
    user = User.create_from_omniauth(auth)
    if user.valid?
      session[:user_id]= user.id
      redirect_to new_user_path
    else 
      flash[:messages] = user.errors.full_messages.join(" - ")
      redirect_to users_path
    end
  end 

  private 
    def auth 
      request.env['omniauth.auth']
    end 
end
