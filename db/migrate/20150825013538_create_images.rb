class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :caption
      t.integer :likes
      t.string :link
      t.references :user, index: true, foreign_key: true
      t.string :url_low_res
      t.string :url_thumb
      t.string :url
      t.string :instagram_id

      t.timestamps null: false
    end
  end
end
