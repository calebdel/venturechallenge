class AddBadgeArrayToStores < ActiveRecord::Migration
  def change
    add_column :stores, :badge_array, :string
  end
end
