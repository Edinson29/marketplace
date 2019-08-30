class UsersController < ApplicationController
  def index
  end

  def new
    @users = User.new
  end

  def create
    @user = User.new(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :cellphone, :address)
  end
end
