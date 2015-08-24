class UsersController < ApplicationController
  def show
    @user = current_user
    @album = Album.new
  end
end
