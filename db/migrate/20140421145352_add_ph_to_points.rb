class AddPhToPoints < ActiveRecord::Migration
  def change
  	add_column :points, :ph, :integer
  end
end
