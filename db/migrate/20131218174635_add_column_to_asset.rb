class AddColumnToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :badge_id, :integer
  end
end
