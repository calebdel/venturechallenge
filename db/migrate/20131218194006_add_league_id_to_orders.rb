class AddLeagueIdToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :league_id, :integer
  end
end
