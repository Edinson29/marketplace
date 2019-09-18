class UsersController < ApplicationController
  before_action :set_user, except: %i[index new create]
  before_action :authenticate_user!

  def index
    @users = User.order("id ASC")
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @user.delete
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :cellphone, :address, :password, :password_confirmation)
  end
end
