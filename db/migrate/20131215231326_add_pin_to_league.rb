class AddPinToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :pin, :integer
  end
end
