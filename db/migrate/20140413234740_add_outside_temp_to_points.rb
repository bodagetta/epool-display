class AddOutsideTempToPoints < ActiveRecord::Migration
  def change
    add_column :points, :outside_temp, :decimal
  end
end
