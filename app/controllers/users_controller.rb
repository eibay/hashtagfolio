class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update_media, :edit, :update]
  before_action :check_logged_in, only: [:update_media, :edit, :update]
  before_action :check_correct_user, only: [:update_media, :edit, :update]

  def show
    @user = User.find params[:id]
    @albums = @user.albums

    respond_to do |format|
      format.html
      format.json { render json: { albums: @albums.to_json(methods: [:cover_url, :tag_list, :owner_profile_image_url]), user_cover_url: @user.cover.url } }
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = "Details updated."
      redirect_to @user
    else
      render :edit
    end
  end

  def update_media
    unless @user.sync_status == "syncing"
      client = Instagram.client(access_token: @user.instagram_access_token)
      response = InstagramUserImagesAPI.fetch(client)
      @user.sync_images(response)
    end

    respond_to do |format|
      format.html { redirect_to @user }
      format.json { render json: @user }
    end
  end

  private
    def user_params
      params.require(:user).permit(:bio, :email)
    end

    def set_user
      @user = User.find params[:id]
    end

    def check_correct_user
      unless @user == current_user
        flash[:error] = "You are not authorised to do that."
        redirect_to root_url
      end
    end

end
