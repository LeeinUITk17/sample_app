class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.newest
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t(".create_success")
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    return if @user

    flash[:danger] = t("users.show.not_found")
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit(:name, :email, :birthday)
  end
end
