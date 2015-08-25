class Image < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags

  def tag_names
    tags.map { |tag| tag.name }
  end
end
