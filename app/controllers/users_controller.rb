class UsersController < ApplicationController
  def index
    @users = User.all_alkp
  end
  def new
    @user = User.new
    respond_to do |format|
      format.js
      format.html
    end
  end
  def change_password
    @user = User.find(current_user.id)
  end
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end
  def update
    if current_user.admin?
      user = User.find(params[:id])
    else
      user = User.find(current_user.id)
    end
    if user.update(users_params)
      current_user.admin? ? (redirect_to users_path) : (redirect_to root_path)
    else
      current_user.admin? ? (render 'show') : (redirect_to root_path)
    end
  end
  def destroy
    user = User.find(params[:id])
    #user.destroy
    User.destroy user
    redirect_to users_path
  end
  def create
    @user = User.new(users_params)
    if @user.save
      redirect_to users_path
    else
      render "new"
    end
    end
  private
  def users_params
    params.require(:user).permit( :name, :email, :admin, :password, :password_confirmation)
  end
end
