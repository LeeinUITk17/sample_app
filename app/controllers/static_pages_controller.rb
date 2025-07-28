class StaticPagesController < ApplicationController
  # GET /contact
  def contact
    @name = t("static_pages.contact.name")
  end
end
