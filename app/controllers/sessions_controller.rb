class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      handle_successful_login(user)
    else
      flash.now[:danger] = t(".invalid_combination")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end

  private
  def handle_successful_login user
    if user.activated?
      log_in_and_remember(user)
    else
      flash[:warning] = t(".account_not_activated_html")
      redirect_to root_url
    end
  end

  def log_in_and_remember user
    forwarding_url = session[:forwarding_url]
    reset_session
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_to forwarding_url || user
  end
end
