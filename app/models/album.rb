class Album < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  belongs_to :cover, class_name: "Image"

  validates :user, presence: true

  def images
    user.images.select { |image| (tags - image.tags).empty? }
  end

  def image_count
    images.count
  end

  def tag_list
    tags_string = ""
    tags.each do |tag|
      tags_string += "\##{tag.name} "
    end
    tags_string
  end

  def cover_url
    cover.url if cover
  end

  def owner_profile_image_url
    user.profile_image_url
  end

end
