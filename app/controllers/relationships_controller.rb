class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user_to_follow, only: :create
  before_action :load_relationship_to_unfollow, only: :destroy

  # POST /relationships
  def create
    current_user.follow(@user)
    respond_to do |format|
      format.html{redirect_to @user}
      format.turbo_stream
    end
  end

  # DELETE /relationships/:id
  def destroy
    current_user.unfollow(@user)
    respond_to do |format|
      format.html{redirect_to @user, status: :see_other}
      format.turbo_stream
    end
  end

  private

  def load_user_to_follow
    @user = User.find_by(id: params[:followed_id])
    return if @user

    flash[:danger] = t("users.show.not_found")
    redirect_to root_url
  end

  def load_relationship_to_unfollow
    relationship = current_user.active_relationships.find_by(id: params[:id])
    unless relationship
      flash[:danger] = t("relationships.not_found")
      return redirect_to root_url, status: :see_other
    end
    @user = relationship.followed
  end
end
