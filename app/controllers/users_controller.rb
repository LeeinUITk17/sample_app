class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :set_user,       only: %i(show edit update destroy)
  before_action :correct_user,   only: %i(edit update)
  before_action :admin_user,     only: :destroy

  # GET /users
  def index
    @pagy, @users = pagy(User.newest, items: User::PAGINATE_PER)
  end

  # GET /users/:id
  def show; end

  # GET /users/new || GET /signup
  def new
    @user = User.new
  end

  # GET /users/:id/edit
  def edit; end

  # POST /users
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

  # PATCH/PUT /users/:id
  def update
    if @user.update(user_params)
      flash[:success] = t(".update_success")
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    if @user.destroy
      flash[:success] = t(".destroy_success")
    else
      flash[:danger] = t(".destroy_fail")
    end
    redirect_to users_url, status: :see_other
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    return if @user

    flash[:danger] = t("users.show.not_found")
    redirect_to root_url, status: :see_other
  end

  def user_params
    params.require(:user).permit(User::USER_PERMIT)
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t("shared.please_log_in")
    redirect_to login_url, status: :see_other
  end

  def correct_user
    return if current_user?(@user)

    flash[:danger] = t("shared.not_authorized")
    redirect_to root_url, status: :see_other
  end

  def admin_user
    return if current_user.admin?

    flash[:danger] = t("shared.require_admin")
    redirect_to root_url, status: :see_other
  end
end
