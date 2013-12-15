class AddColumnstoUser < ActiveRecord::Migration
  def change
  	add_column :users, :linkedin_uid, :string
  	add_column :users, :phone, :string
  	add_column :users, :linkedin_token, :string
  	add_column :users, :shopify_token, :string
  	remove_column :users, :token
  	remove_column :users, :password_digest

  end
end
