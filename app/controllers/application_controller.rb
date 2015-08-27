class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include OauthHelper

  private

    def check_logged_in
      unless logged_in?
        flash[:alert] = "Please log in."
        redirect_to root_url
      end
    end
end
