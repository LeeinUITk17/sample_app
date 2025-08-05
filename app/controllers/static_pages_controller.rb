class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: :home

  # GET /static_pages/home
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @pagy, @feed_items = pagy(current_user.feed, items: 10)
  end

  # GET /contact
  def contact
    @name = t("static_pages.contact.name")
  end
end
