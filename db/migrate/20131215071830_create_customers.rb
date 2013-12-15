class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
    t.integer  :customer_id
    t.string   :city
    t.boolean  :accepts_marketing
    t.integer  :orders_count
    t.integer  :total_spent
    t.datetime :created_at
    t.datetime :updated_at

      t.timestamps
    end
  end
end
