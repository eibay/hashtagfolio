class Tag < ActiveRecord::Base
  has_many :albums
  has_and_belongs_to_many :images

  validates :name, uniqueness: true

end
