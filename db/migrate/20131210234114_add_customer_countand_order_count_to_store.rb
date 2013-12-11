class AddCustomerCountandOrderCountToStore < ActiveRecord::Migration
  def change
    add_column :stores, :customer_count, :integer
    add_column :stores, :order_count, :integer
  end
end
