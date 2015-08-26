class AddUniqueIndexes < ActiveRecord::Migration
  def change
    remove_index :albums, [:user_id, :tag_id] if index_exists?(:albums, [:user_id, :tag_id])
    add_index :albums, [:user_id, :tag_id], unique: true

    remove_index :images, :instagram_id if index_exists?(:images, :instagram_id)
    add_index :images, :instagram_id, unique: true

    remove_index :images_tags, [:image_id, :tag_id] if index_exists?(:images_tags, [:image_id, :tag_id])
    add_index :images_tags, [:image_id, :tag_id], unique: true

    remove_index :tags, :name if index_exists?(:tags, :name)
    add_index :tags, :name, unique: true

    remove_index :users, :instagram_id if index_exists?(:users, :instagram_id)
    add_index :users, :instagram_id, unique: true
  end
end
