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
    user = User.find_or_initialize_by instagram_id: response.user.id do |u|
      u.instagram_access_token = response.access_token
      u.profile_image_url = response.user.profile_picture
      u.name = response.user.full_name
      u.instagram_username = response.user.username
    end

    new_user = user.new_record?
    if user.save
      log_in user

      if new_user
        flash[:success] = "You have successfully signed up. Welcome!"
        redirect_to edit_user_path(user)
      else
        flash[:success] = "Welcome back."
        redirect_to dashboard_path
      end
    else
      flash[:error] = "Something went wrong."
      redirect_to root_url
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
