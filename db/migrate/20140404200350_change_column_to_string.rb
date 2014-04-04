class ChangeColumnToString < ActiveRecord::Migration
  def change
        change_column :orders, :referring_site, :string
  end
end
