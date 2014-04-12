class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :shortAddr
      t.string :extAddr
      t.string :nodeType
      t.integer :temperature
      t.integer :softVersion
      t.integer :battery
      t.integer :light
      t.integer :messageType
      t.integer :workingChannel
      t.integer :sensorSize
      t.integer :lqi
      t.integer :rssi
      t.integer :parentShortAddr
      t.integer :painID
      t.string :channelMask

      t.timestamps
    end
  end
end
