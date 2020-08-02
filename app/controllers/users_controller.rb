class UsersController < ApplicationController
  skip_before_action :require_login, only:[:new, :create]

  def index 
    @users = User.all
  end 
  
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
      redirect_to user_path(@user.id)

    else 
      redirect_to signup_path
    end
  end

  def edit
    @user = User.new
  end

  def update
    @user = User.find_by(:id, params[:id])
    if current_user == @user
      @user.update(user_params)
      redirect_to user_path(@user.id)
    else 
      flash[:message] = "Not yours to change"
      redirect_to users_path
    end 
  end 
  

  def delete
    user = User.find_by[id: params[:id]]
    if current_user == user
      user.delete
      flash[:message] = "Not yours to delete"
      redirect_to root_path 
    end
  end 

  private 

  def user_params 
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end 

end
