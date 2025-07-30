class UsersController < ApplicationController
  before_action :logged_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :set_user,
                only: [:show, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def following
    @title = t(".title")
    @pagy, @users = pagy(@user.following, items: 10)
    render "show_follow"
  end

  def followers
    @title = t(".title")
    @pagy, @users = pagy(@user.followers, items: 10)
    render "show_follow"
  end

  def index
    @pagy, @users = pagy(User.newest, items: 10)
  end

  def show
    @pagy, @microposts = pagy(@user.microposts, items: 10)
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = t(".activation_email_sent")
      redirect_to root_url
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
    User.find(params[:id]).destroy
    flash[:success] = t(".destroy_success")
    redirect_to users_url, status: :see_other
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name, :email, :password,
      :password_confirmation, :birthday, :gender, :avatar
    )
  end

  def correct_user
    redirect_to(root_url, status: :see_other) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url, status: :see_other) unless current_user.admin?
  end
end
