class Tag < ActiveRecord::Base
  has_many :albums
  has_and_belongs_to_many :images
  has_and_belongs_to_many :albums

  validates :name, uniqueness: true

end
