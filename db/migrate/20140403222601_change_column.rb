class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :orders, :referring_site, :text, :limit => nil
  end
end
