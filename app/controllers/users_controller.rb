class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update_media]
  before_action :check_logged_in, only: :update_media
  before_action :check_correct_user, only: :update_media

  def show
    @album = Album.new if logged_in?
  end

  def update_media
    client = Instagram.client(access_token: @user.instagram_access_token)
    response = InstagramUserImagesAPI.fetch(client)
    @user.sync_images(response)
    redirect_to @user
  end

  private

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
