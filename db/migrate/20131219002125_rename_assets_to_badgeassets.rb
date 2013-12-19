class RenameAssetsToBadgeassets < ActiveRecord::Migration
  def change
  	rename_table :assets, :badgeassets
  end
end
