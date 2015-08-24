class User < ActiveRecord::Base
  has_many :albums, dependent: :destroy

  def display_name
    name.blank? ? instagram_username : name
  end
end
