class CreateImagesTagsJoinTable < ActiveRecord::Migration
  def change
    create_table :images_tags, id: false do |t|
      t.belongs_to :image, index: true
      t.belongs_to :tag, index: true
    end
  end
end
