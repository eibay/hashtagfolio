class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :destroy]
  before_action :check_logged_in, only: [:create]
  before_action :check_album_owner, only: [:destroy]

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @albums = @user.albums
    else
      @albums = Album.all
    end

    respond_to do |format|
      format.html
      format.json { render json: @albums.to_json(methods: [:cover_url, :tag_list]) }
    end
  end

  def show
    @images = @album.images
    @owner = @album.user

    respond_to do |format|
      format.html
      format.json { render json: @images }
    end
  end

  def create
    tag_names = params[:query].scan(/\w+/)
    tag_records = []
    tag_names.each do |tag_name|
      tag_records << Tag.find_or_create_by(name: tag_name)
    end

    @album = current_user.albums.build
    @album.tags = tag_records
    @album.cover = @album.images.sample
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
