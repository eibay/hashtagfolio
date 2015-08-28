class StaticPagesController < ApplicationController
  def index
    redirect_to dashboard_path if logged_in?
    @albums = Album.all.order(created_at: :desc).limit(24)
  end
end
