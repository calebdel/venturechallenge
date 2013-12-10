class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :store_id
      t.float :total_price

      t.timestamps
    end
  end
end
