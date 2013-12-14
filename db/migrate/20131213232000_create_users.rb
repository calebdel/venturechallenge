class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :token
      t.string :url
      t.integer :shop_id

      t.timestamps
    end
  end
end
