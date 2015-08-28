class RemoveSyncedFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :synced, :boolean
  end
end
