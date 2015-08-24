class AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end

  def show
    @album = Album.find params[:id]
    @user = @album.user
    client = Instagram.client access_token: @user.instagram_access_token
    @photos = client.user_recent_media.map { |photo| photo.images.standard_resolution }
  end
end
