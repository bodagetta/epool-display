class FixColumnNames < ActiveRecord::Migration
  def change
    rename_column :points, :painID, :panID
    rename_column :points, :sensorSize, :sensorsSize
  end
end
