class UsersController < ApplicationController
  skip_before_action :require_login, only:[:new, :create]

  def show
   @user = User.find(params[:id])
  end 

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id 
      redirect_to businesses_path
    else 
      flash[:messages] = @user.errors.full_messages.join(" - ")
      redirect_to signup_path
    end
  end


  def destroy
    user = User.find_by[id: params[:id]]
    if current_user == user
      user.delete
      redirect_to root_path 
    end
  end 

  private 

  def user_params 
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end 

end
