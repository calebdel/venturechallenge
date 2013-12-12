class ChangeUsertoStore < ActiveRecord::Migration
  def change
    remove_column :points, :user_id
    add_column :points, :store_id, :integer
  end
end
