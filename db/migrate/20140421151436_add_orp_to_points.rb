class AddOrpToPoints < ActiveRecord::Migration
  def change
  	add_column :points, :orp, :integer
  end
end
