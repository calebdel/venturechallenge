class RemoveShopIdFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :shop_id
  	add_column :users, :store_id, :integer
  end
end
