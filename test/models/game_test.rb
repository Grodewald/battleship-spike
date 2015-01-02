require 'test_helper'

class GameTest < ActiveSupport::TestCase
  fixtures :games, :guesses
  # test "the truth" do
  #   assert true
  # end

  test "get_cell_value returns the proper value" do
    game = Game.new   
    rows = game.rows
    cols = game.columns
    assert_equal (rows.length * 3 + 5),  (game.get_cell_value cols[3], rows[5])
  end

  test "get_cell_value returnd nil when out of range" do
    game = Game.new
    assert_nil game.get_cell_value 'out range value 1', 'out of range value 2'
  end

  test "has_cell_been_guessed returns true when the cell has been guessed" do 
    game = Game.new
    game.guesses.build(guess_value:13, is_hit: false)
    assert game.has_cell_been_guessed('2', 'D')
  end 

  test "has_cell_been_guessed retuens false when the cell has not been guessed" do
    game = Game.new
    assert_not game.has_cell_been_guessed('2', 'D')
  end

  test "has_cell_been_guessed returns nil when out of range" do 
    game = Game.new
    assert_nil game.has_cell_been_guessed('out of range value 1', 'out of range value 2')
  end

  test "get_guess_at returns the guess at the cell" do
    game = Game.new
    game.guesses.build(guess_value:13, is_hit: false)
    assert_equal game.guesses[0], game.get_guess_at('2', 'D')
  end

  test "get_guess_at returns nill when the cell has not been guessed" do 
    game = Game.new
    game.guesses.build(guess_value:13, is_hit: false)
    assert_nil game.get_guess_at('2', 'C')
  end

  test "register_guess_at returns the guess registered" do
    game = Game.new
    guess = game.register_guess_at '2','C'
    assert_instance_of Guess, guess
    assert_equal game.get_cell_value('2', 'C'), guess.guess_value
  end

  test "register_guess_at returns nil if the guess was out of range" do
    game = Game.new
    guess = game.register_guess_at "out of range value 1", 'out of range value 2'
    assert_nil guess
  end

  test "register_guess_at does not add multiple guesses of the same value to the guesses list" do
    game = Game.new
    guess = game.register_guess_at '2', 'C'
    assert_equal 1, game.guesses.length
    assert_instance_of Guess, guess
    guess1 = game.register_guess_at '2', 'C'
    assert_equal 1, game.guesses.length
    assert_instance_of Guess, guess1
  end

  test "register_guess_value returns the guess registered" do
    game = Game.new
    guess = game.register_guess_value 15
    assert_instance_of Guess, guess
    assert_equal 15 , guess.guess_value
  end

  test "register_guess_value returns nil if the guess was out of range" do
    game = Game.new
    guess = game.register_guess_value 103
    assert_nil guess
    guess1 = game.register_guess_value -1
    assert_nil guess1
  end

  test "register_guess_value does not add multiple guesses of the same value to the guesses list" do
    game = Game.new
    guess = game.register_guess_value 12
    assert_equal 1, game.guesses.length
    assert_instance_of Guess, guess
    guess1 = game.register_guess_value 12
    assert_equal 1, game.guesses.length
    assert_instance_of Guess, guess1
  end

  test "place_ship returns a ship_placement at the with the top_left_value and orientation specified" do
    game = Game.new
    ship = Ship.new(name: 'TestShip', size: 3)
    ship_placement = game.place_ship(ship, 5, :horizontal)
    assert_instance_of ShipPlacement,  ship_placement
    assert_equal 5, ship_placement.top_left_value
    assert_equal 'horizontal', ship_placement.orientation 
  end

  test "place_ship returns nil when top_left_value is placed outside the range" do
    game = Game.new
    ship = Ship.new(name: 'TestShip', size: 3)
    ship_placement = game.place_ship(ship, -1, :horizontal)
    assert_nil ship_placement
    ship_placement1 = game.place_ship(ship, 105, :vertical)
    assert_nil ship_placement1
  end

  test "place_ship returns nil when length puts part of the ship out of range" do 
    game = Game.new
    ship = Ship.new(name: 'TestShip', size: 3)

    #right tip should be off board
    ship_placement = game.place_ship(ship, 80, :horizontal)
    assert_nil ship_placement

    #80 should work if vertival alignment
    ship_placement1 = game.place_ship(ship, 80, :vertival)
    assert_not_nil ship_placement1

    #bottom of ship is not on board
    ship_placement2 = game.place_ship(ship, 8, :vertival)
    assert_nil ship_placement2

    #8 should work if horizontal alignment
    ship_placement3 = game.place_ship(ship, 8, :horizontal)
    assert_not_nil ship_placement3
  end

  test 'register_guess returns a guess with a miss when a ship is not hit' do 
    game = Game.new
    ship = Ship.new(name: 'TestShip', size: 3)
    ship_placement = game.place_ship(ship, 20, :horizontal)
    guess = game.register_guess_value 21
    assert_not guess.is_hit
    guess1 = game.register_guess_at '1', 'A'
    assert_not guess1.is_hit
  end

  test 'register_guess returns a guess with a hit when a ship is hit' do 
    game = Game.new
    ship = Ship.new(name: 'TestShip', size: 3)
    ship_placement = game.place_ship(ship, 20, :horizontal)
    guess = game.register_guess_value 20;
    assert guess.is_hit
    guess1 = game.register_guess_value 30;
    assert guess1.is_hit
    guess2 = game.register_guess_at '4', 'A'
    assert guess2.is_hit
  end

end