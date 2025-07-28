class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.newest
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
      reset_session
      log_in @user
      flash[:success] = t(".create_success")
      redirect_to @user
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
    params.require(:user).permit(User::USER_PERMIT)
  end
end
