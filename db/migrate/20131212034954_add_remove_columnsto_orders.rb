class AddRemoveColumnstoOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :json
    add_column :orders, :subtotal_price, :float
    add_column :orders, :shopify_id, :string
    add_column :orders, :referring_site, :string
    add_column :orders, :total_discounts, :integer
    add_column :orders, :cost, :float
  end
end
