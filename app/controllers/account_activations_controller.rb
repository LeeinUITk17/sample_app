class AccountActivationsController < ApplicationController
  before_action :load_user
  before_action :check_activation_status
  before_action :authenticate_user

  # GET /account_activations/:id/edit
  def edit
    @user.activate
    log_in @user
    flash[:success] = t(".success")
    redirect_to @user
  end

  private

  def load_user
    @user = User.find_by(email: params[:email])
    return if @user

    handle_invalid_activation
  end

  def check_activation_status
    return unless @user.activated?

    handle_invalid_activation
  end

  def authenticate_user
    return if @user.authenticated?(:activation, params[:id])

    handle_invalid_activation
  end

  def handle_invalid_activation
    flash[:danger] = t(".invalid_link")
    redirect_to root_url
  end
end
