class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in_and_remember(user)
      redirect_to user
    else
      flash.now[:danger] = t(".invalid_combination")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def log_in_and_remember user
    reset_session
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
  end
end
