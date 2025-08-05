class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :load_micropost, only: :destroy
  before_action :correct_user, only: :destroy

  # GET /microposts
  def index; end

  # POST /microposts
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = t(".created_success")
      redirect_to root_url
    else
      @pagy, @feed_items = pagy(current_user.feed.newest,
                                items: Micropost::PAGINATE_PER)
      render "static_pages/home", status: :unprocessable_entity
    end
  end

  # DELETE /microposts/:id
  def destroy
    if @micropost.destroy
      flash[:success] = t(".deleted_success")
    else
      flash[:danger] = t(".deleted_fail")
    end
    redirect_to root_url, status: :see_other
  end

  private

  def micropost_params
    params.require(:micropost).permit(Micropost::MICROPOST_PERMIT)
  end

  def load_micropost
    @micropost = Micropost.find_by(id: params[:id])
    return if @micropost

    flash[:danger] = t("microposts.not_found")
    redirect_to root_url
  end

  def correct_user
    return if @micropost.user == current_user

    flash[:danger] = t("shared.not_authorized")
    redirect_to root_url, status: :see_other
  end
end
