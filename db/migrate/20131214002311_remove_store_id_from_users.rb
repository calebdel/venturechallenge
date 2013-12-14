class RemoveStoreIdFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :store_id
  	add_column :stores, :user_id, :integer
  end
end
