class RemoveColumnBadge < ActiveRecord::Migration
  def change
    remove_column :badges, :imgurl
  end
end
