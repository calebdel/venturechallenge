class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :shop

      t.timestamps
    end
  end
end
