json.array!(@guesses) do |guess|
  json.extract! guess, :id, :game_id, :guess_value
  json.url guess_url(guess, format: :json)
end
