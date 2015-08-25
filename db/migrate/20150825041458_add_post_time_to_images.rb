class AddPostTimeToImages < ActiveRecord::Migration
  def change
    add_column :images, :post_time, :timestamp
  end
end
