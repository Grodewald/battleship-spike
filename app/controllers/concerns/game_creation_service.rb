class GameCreationService

  def generate_game(name)
    board = Board.all[0]
    game = Game.new(name: name, board:board)
    Ship.all.each do |ship|
      placement = nil
      until placement do
        placement = game.place_ship(ship, Random.rand(100), (Random.rand(2) == 0 ? :horizontal : :vertical))
      end
      placement.save
    end 
    game
  end

end