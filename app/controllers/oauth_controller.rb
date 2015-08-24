class OauthController < ApplicationController
  CALLBACK_URL = "http://localhost:3000/oauth/callback"

  def connect
    if logged_in?
      redirect_to root_url
    else
      redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
    end
  end

  def callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    user = User.find_by instagram_id: response.user.id
    user ||= User.create({
      instagram_id: response.user.id,
      instagram_access_token: response.access_token,
      profile_image_url: response.user.profile_picture,
      name: response.user.full_name,
      instagram_username: response.user.username
    })
    log_in user
    redirect_to root_url
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
