class RemoveUrLandTokenFromStores < ActiveRecord::Migration
  def change
  	remove_column :stores, :myshopify_domain
  	remove_column :stores, :access_token
  end
end
