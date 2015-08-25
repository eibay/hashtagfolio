class Album < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag

  def images
    user.images.select { |image| image.tags.exists?(tag.id) }
  end

  def image_count
    images.count
  end
  # def tagged_images
  #   instagetter = Instagetter.new user
  #   tagged_images = instagetter.images_tagged tag
  #   self.update_attribute :image_count, tagged_images.count
  #   user = instagetter.user_details
  #   {
  #     user: user,
  #     images: tagged_images
  #   }
  # end

end
