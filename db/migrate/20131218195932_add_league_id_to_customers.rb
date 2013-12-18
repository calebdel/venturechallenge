class AddLeagueIdToCustomers < ActiveRecord::Migration
  def change
  	add_column :customers, :league_id, :integer
  end
end
