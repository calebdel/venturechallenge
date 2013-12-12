class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.integer :kind_id
      t.integer :points
      t.boolean :default

      t.timestamps
    end
  end
end
