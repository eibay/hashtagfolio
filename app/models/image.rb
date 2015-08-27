class Image < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags

  validates :user, :instagram_id, presence: true
  validates :instagram_id, uniqueness: true

  def tag_names
    tags.map { |tag| tag.name }
  end

  def tag_list
    tags_string = ""
    tags.each do |tag|
      tags_string += "\##{tag.name} "
    end
    tags_string
  end

end
