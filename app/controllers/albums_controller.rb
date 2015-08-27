class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :destroy]
  before_action :check_logged_in, only: [:create]
  before_action :check_album_owner, only: [:destroy]

  def index
    @albums = Album.all
  end

  def show
    @images = @album.images
    @user = @album.user
  end

  def create
    tag_names = params[:tag].scan(/\w+/)
    tag_records = []
    tag_names.each do |tag_name|
      tag_records << Tag.find_or_create_by(name: tag_name)
    end

    @album = current_user.albums.build
    @album.tags = tag_records
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

    def set_album
      @album = Album.find params[:id]
    end

    def check_album_owner
      unless @album.user == current_user
        flash[:error] = "You are not authorised to do that."
        redirect_to root_url
      end
    end

end
