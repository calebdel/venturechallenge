class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :myshopify_domain
      t.string :access_token

      t.timestamps
    end
  end
end
