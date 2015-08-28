class StaticPagesController < ApplicationController
  def index
    redirect_to dashboard_path if logged_in?
    @albums = Album.all
  end
end
