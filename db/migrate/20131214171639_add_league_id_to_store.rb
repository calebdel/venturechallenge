class AddLeagueIdToStore < ActiveRecord::Migration
  def change
    add_column :stores, :league_id, :integer
  end
end
