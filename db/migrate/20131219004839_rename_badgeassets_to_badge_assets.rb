class RenameBadgeassetsToBadgeAssets < ActiveRecord::Migration
  def change
  	rename_table :badgeassets, :badge_assets
  end
end
