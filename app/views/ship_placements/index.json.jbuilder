json.array!(@ship_placements) do |ship_placement|
  json.extract! ship_placement, :id, :ship_id, :game_id, :top_left_value, :orientation
  json.url ship_placement_url(ship_placement, format: :json)
end
