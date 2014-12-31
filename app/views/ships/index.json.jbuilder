json.array!(@ships) do |ship|
  json.extract! ship, :id, : name, :size
  json.url ship_url(ship, format: :json)
end
