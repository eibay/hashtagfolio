class AddTagIdToAlbums < ActiveRecord::Migration
  def change
    add_reference :albums, :tag, index: true, foreign_key: true
  end
end
