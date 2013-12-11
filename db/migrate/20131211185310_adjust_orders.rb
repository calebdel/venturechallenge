class AdjustOrders < ActiveRecord::Migration
  def change
  	remove_column :orders, :total_price
  	add_column :orders, :json, :text
  end
end
