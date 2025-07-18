class StaticPagesController < ApplicationController
  def contact
    @name = t("static_pages.contact.name")
  end
end
