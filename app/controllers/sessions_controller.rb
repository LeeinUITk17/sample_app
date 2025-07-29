class SessionsController < ApplicationController
  REMEMBER_ME_CHECKED = "1".freeze
  before_action :find_user_and_authenticate, only: :create

  # GET /login
  def new; end

  # POST /login
  def create
    log_in_and_remember(@user)
    redirect_to @user
  end

  # DELETE /logout
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def log_in_and_remember user
    reset_session
    log_in user
    if params.dig(:session,
                  :remember_me) == REMEMBER_ME_CHECKED
      remember(user)
    else
      forget(user)
    end
  end

  def find_user_and_authenticate
    email = params.dig(:session, :email)&.downcase
    password = params.dig(:session, :password)

    @user = User.find_by(email:)

    return if @user&.authenticate(password)

    flash.now[:danger] = t(".invalid_combination")
    render :new, status: :unprocessable_entity
  end
end
