json.array!(@points) do |point|
  json.extract! point, :id, :shortAddr, :extAddr, :nodeType, :temperature, :softVersion, :battery, :light, :messageType, :workingChannel, :sensorsSize, :lqi, :rssi, :parentShortAddr, :panID, :channelMask
  json.url point_url(point, format: :json)
end
