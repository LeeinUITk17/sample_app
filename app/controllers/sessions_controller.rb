class SessionsController < ApplicationController
  before_action :find_user_and_authenticate, only: :create

  # GET /login
  def new; end

  # POST /login
  def create
    reset_session
    log_in @user
    redirect_to @user
  end

  # DELETE /logout
  def destroy
    log_out
    redirect_to root_url
  end

  private

  def find_user_and_authenticate
    email = params.dig(:session, :email)&.downcase
    password = params.dig(:session, :password)

    @user = User.find_by(email:)

    return if @user&.authenticate(password)

    flash.now[:danger] = t(".invalid_combination")
    render :new, status: :unprocessable_entity
  end
end
