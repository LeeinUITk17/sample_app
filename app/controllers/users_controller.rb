class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.newest
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = t(".create_success")
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = t(".update_success")
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t(".destroy_success")
    redirect_to users_url
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    return if @user

    flash[:danger] = t("users.show.not_found")
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit(
      :name, :email, :password,
      :password_confirmation, :birthday, :gender, :avatar
    )
  end
end
