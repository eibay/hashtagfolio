class AddCoverToUserAndAlbum < ActiveRecord::Migration
  def change
    add_column :users, :cover_id, :integer
    add_column :albums, :cover_id, :integer
  end
end
