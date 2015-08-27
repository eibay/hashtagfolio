class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update_media, :edit, :update]
  before_action :check_logged_in, only: [:update_media, :edit, :update]
  before_action :check_correct_user, only: [:update_media, :edit, :update]

  def show
    @user = User.find params[:id]
    # @album = Album.new if logged_in?
    @albums = Album.where user_id: params[:id]
  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = "Details updated successfully."
      redirect_to @user
    else
      render :edit
    end
  end

  def update_media
    client = Instagram.client(access_token: @user.instagram_access_token)
    response = InstagramUserImagesAPI.fetch(client)
    @user.sync_images(response)
    redirect_to @user
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
