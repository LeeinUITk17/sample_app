class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = t(".created_success")
      redirect_to root_url
    else
      @pagy, @feed_items = pagy(current_user.feed, items: 10)
      render "static_pages/home", status: :unprocessable_entity
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = t(".deleted_success")
    redirect_back(fallback_location: root_url, status: :see_other)
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @micropost.nil?
  end
end
