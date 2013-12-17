class AddColumnToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :imgurl, :string
  end
end
