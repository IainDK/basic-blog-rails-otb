class UsersController < ApplicationController

  before_action :require_permisson, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def new
    redirect_to '/' if current_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def require_permisson
    user_profile = User.find(params[:id])
    unless current_user == user_profile
      flash[:notice] = "You do not have persmission to edit this user's profile."
      redirect_to posts_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
