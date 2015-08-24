class AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end

  def show
    @album = Album.find params[:id]
    user = @album.user
    @images = @album.images
  end
end
