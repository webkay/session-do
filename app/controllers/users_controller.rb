class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password_confirmation = user_params[:password]
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
