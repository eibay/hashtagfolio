class Album < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags

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

end
