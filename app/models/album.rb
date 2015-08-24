class Album < ActiveRecord::Base
  belongs_to :user

  def images
    user.all_images.select { |image| image[:tags].include? tag }
  end
end
