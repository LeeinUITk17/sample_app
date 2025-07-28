class MicropostsController < ApplicationController
  # GET /microposts
  def index
    @microposts = Micropost.most_recent
  end
end
