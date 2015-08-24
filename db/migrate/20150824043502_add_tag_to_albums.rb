class AddTagToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :tag, :string
  end
end
