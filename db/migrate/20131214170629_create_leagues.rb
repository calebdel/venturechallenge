class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.integer :admin_id
      t.datetime :start_date
      t.datetime :end_date
      t.string :school

      t.timestamps
    end
  end
end
