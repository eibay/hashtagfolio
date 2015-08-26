class Album < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag
  accepts_nested_attributes_for :tag

  validates :tag, uniqueness: { scope: :user }
  validates :user, :tag, presence: true

  def images
    user.images.select { |image| image.tags.exists?(tag.id) }
  end

  def image_count
    images.count
  end

end
