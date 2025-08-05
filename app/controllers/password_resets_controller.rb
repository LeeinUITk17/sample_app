class PasswordResetsController < ApplicationController
  before_action :load_user_for_create, only: :create
  before_action :load_user_by_email, only: %i(edit update)
  before_action :valid_user, only: %i(edit update)
  before_action :check_expiration, only: %i(edit update)
  before_action :check_empty_password, only: :update

  # GET /password_resets/new
  def new; end

  # POST /password_resets
  def create
    @user.create_reset_digest
    @user.send_password_reset_email
    flash[:info] = t(".email_sent")
    redirect_to root_url
  end

  # GET /password_resets/:id/edit
  def edit; end

  # PATCH /password_resets/:id
  def update
    if @user.update(user_params.merge(reset_digest: nil))
      handle_successful_update
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private

  PASSWORD_RESET_PERMIT = %i(password password_confirmation).freeze

  def user_params
    params.require(:user).permit(PASSWORD_RESET_PERMIT)
  end

  def load_user_for_create
    @user = User.find_by(email: params.dig(:password_reset, :email)&.downcase)
    return if @user

    flash.now[:danger] = t(".email_not_found")
    render "new", status: :unprocessable_entity
  end

  def load_user_by_email
    @user = User.find_by(email: params[:email])
    return if @user

    flash[:danger] = t("users.show.not_found")
    redirect_to root_url
  end

  def valid_user
    return if @user.activated? && @user.authenticated?(:reset, params[:id])

    flash[:danger] = t(".invalid_link")
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t(".password_reset_expired")
    redirect_to new_password_reset_url
  end

  def check_empty_password
    return unless params.dig(:user, :password).empty?

    @user.errors.add(:password, :blank)
    render "edit", status: :unprocessable_entity
  end

  def handle_successful_update
    reset_session
    log_in @user
    flash[:success] = t(".password_reset_success")
    redirect_to @user
  end
end
