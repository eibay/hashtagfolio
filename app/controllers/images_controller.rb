class ImagesController < ApplicationController
  def index
    @images = current_user.images if logged_in?
  end
end
