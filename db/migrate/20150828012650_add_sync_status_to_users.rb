class AddSyncStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sync_status, :string, default: "waiting"
  end
end
