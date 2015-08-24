class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :destroy]
  before_action :check_logged_in, only: [:create]
  before_action :check_album_owner, only: [:destroy]

  def index
    @albums = Album.all
    @album = Album.new
  end

  def show
    user = @album.user
    @images = @album.tagged_images
  end

  def create
    @album = current_user.albums.build album_params
    if @album.save
      flash[:success] = "Successfully created album!"
      redirect_to @album
    else
      flash[:error] = "Could not save album."
      redirect_to root_url
    end
  end

  def destroy
    @album.destroy
    redirect_to root_url
  end

  private
    def album_params
      params.require(:album).permit(:tag)
    end

    def set_album
      @album = Album.find params[:id]
    end

    def check_album_owner
      unless @album.user == current_user
        flash[:danger] = "You are not authorised to do that."
        redirect_to root_url
      end
    end

end
