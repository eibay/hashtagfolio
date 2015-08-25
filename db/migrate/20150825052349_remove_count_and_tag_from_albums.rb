class RemoveCountAndTagFromAlbums < ActiveRecord::Migration
  def change
    remove_column :albums, :tag
    remove_column :albums, :image_count
  end
end
