class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :title
      t.text :content
      t.integer :admin_id
      t.integer :league_id

      t.timestamps
    end
  end
end
