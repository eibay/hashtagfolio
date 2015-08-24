class Album < ActiveRecord::Base
  belongs_to :user

  def tagged_images
    instagetter = Instagetter.new user
    tagged_images = instagetter.images_tagged tag
    self.update_attribute :image_count, tagged_images.count
    tagged_images
  end

end
