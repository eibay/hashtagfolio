class CreateAlbumsTagsTable < ActiveRecord::Migration
  def change
    create_table :albums_tags, id: false do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :album, index: true
    end

    add_index :albums_tags, [:album_id, :tag_id], unique: true
  end
end
