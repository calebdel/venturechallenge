class AddTotalOrdersToStores < ActiveRecord::Migration
  def change
    add_column :stores, :total_orders, :float
  end
end
