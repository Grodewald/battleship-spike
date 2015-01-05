require 'test_helper'

class GameTest < ActiveSupport::TestCase
  fixtures :games, :guesses
  
  setup do
    @board = Board.new(rows: 'A,B,C,D,E,F,G,H,I,J', columns: '1,2,3,4,5,6,7,8,9,10')
    @game = Game.new(name: 'Test Game', board: @board)
  end

  test "has_cell_been_guessed returns true when the cell has been guessed" do 
    @game.guesses.build(guess_value:13, is_hit: false)
    assert @game.has_cell_been_guessed('2', 'D')
  end 

  test "has_cell_been_guessed retuens false when the cell has not been guessed" do
    assert_not @game.has_cell_been_guessed('2', 'D')
  end

  test "has_cell_been_guessed returns nil when out of range" do 
    assert_nil @game.has_cell_been_guessed('out of range value 1', 'out of range value 2')
  end

  test "get_guess_at returns the guess at the cell" do
    @game.guesses.build(guess_value:13, is_hit: false)
    assert_equal @game.guesses[0], @game.get_guess_at('2', 'D')
  end

  test "get_guess_at returns nill when the cell has not been guessed" do 
    @game.guesses.build(guess_value:13, is_hit: false)
    assert_nil @game.get_guess_at('2', 'C')
  end

  test "register_guess_at returns the guess registered" do
    guess = @game.register_guess_at '2','C'
    assert_instance_of Guess, guess
    assert_equal @game.get_cell_value('2', 'C'), guess.guess_value
  end

  test "register_guess_at returns nil if the guess was out of range" do
    guess = @game.register_guess_at "out of range value 1", 'out of range value 2'
    assert_nil guess
  end

  test "register_guess_at does not add multiple guesses of the same value to the guesses list" do
    guess = @game.register_guess_at '2', 'C'
    assert_equal 1, @game.guesses.length
    assert_instance_of Guess, guess
    guess1 = @game.register_guess_at '2', 'C'
    assert_equal 1, @game.guesses.length
    assert_instance_of Guess, guess1
  end

  test "register_guess_value returns the guess registered" do
    guess = @game.register_guess_value 15
    assert_instance_of Guess, guess
    assert_equal 15 , guess.guess_value
  end

  test "register_guess_value returns nil if the guess was out of range" do
    guess = @game.register_guess_value 103
    assert_nil guess
    guess1 = @game.register_guess_value -1
    assert_nil guess1
  end

  test "register_guess_value does not add multiple guesses of the same value to the guesses list" do
    guess = @game.register_guess_value 12
    assert_equal 1, @game.guesses.length
    assert_instance_of Guess, guess
    guess1 = @game.register_guess_value 12
    assert_equal 1, @game.guesses.length
    assert_instance_of Guess, guess1
  end

  test "place_ship returns a ship_placement at the with the top_left_value and orientation specified" do
    ship = Ship.new(name: 'TestShip', size: 3)
    ship_placement = @game.place_ship(ship, 5, :horizontal)
    assert_instance_of ShipPlacement,  ship_placement
    assert_equal 5, ship_placement.top_left_value
    assert_equal 'horizontal', ship_placement.orientation 
  end

  test "place_ship returns nil when top_left_value is placed outside the range" do
    ship = Ship.new(name: 'TestShip', size: 3)
    ship_placement = @game.place_ship(ship, -1, :horizontal)
    assert_nil ship_placement
    ship_placement1 = @game.place_ship(ship, 105, :vertical)
    assert_nil ship_placement1
  end

  test "place_ship returns nil when length puts part of the ship out of range" do 
    ship = Ship.new(name: 'TestShip', size: 3)

    #right tip should be off board
    ship_placement = @game.place_ship(ship, 80, :horizontal)
    assert_nil ship_placement

    #80 should work if vertival alignment
    ship_placement1 = @game.place_ship(ship, 80, :vertival)
    assert_not_nil ship_placement1

    #bottom of ship is not on board
    ship_placement2 = @game.place_ship(ship, 8, :vertival)
    assert_nil ship_placement2

    #8 should work if horizontal alignment
    ship_placement3 = @game.place_ship(ship, 8, :horizontal)
    assert_not_nil ship_placement3
  end

  test "place_ship returns nill when one ship is placed on top of another" do 
    ship = Ship.new(name: 'TestShip', size: 3)
    ship1 = Ship.new(name: 'Ship 1', size: 2)

    ship_placement = @game.place_ship ship, 35, :horizontal

    assert_nil @game.place_ship(ship1, 35, :horizontal)
    assert_nil @game.place_ship(ship1, 25, :horizontal)
    assert_not_nil @game.place_ship(ship1, 15, :horizontal)
  end

  test "place_ship returns nil when ship placements intersect" do
    ship = Ship.new(name: 'TestShip', size: 3)
    ship1 = Ship.new(name: 'Ship 1', size: 3)

    ship_placement = @game.place_ship ship, 35, :vertical

    assert_nil @game.place_ship(ship1, 16, :horizontal)
    assert_nil @game.place_ship(ship1, 26, :horizontal)
    assert_nil @game.place_ship(ship1, 36, :horizontal)
    assert_not_nil @game.place_ship(ship1, 46, :horizontal)
  end

  test 'register_guess returns a guess with a miss when a ship is not hit' do 
    ship = Ship.new(name: 'TestShip', size: 3)
    ship_placement = @game.place_ship(ship, 20, :horizontal)
    guess = @game.register_guess_value 21
    assert_not guess.is_hit
    guess1 = @game.register_guess_at '1', 'A'
    assert_not guess1.is_hit
  end

  test 'register_guess returns a guess with a hit when a ship is hit' do 
    ship = Ship.new(name: 'TestShip', size: 3)
    ship_placement = @game.place_ship(ship, 20, :horizontal)
    guess = @game.register_guess_value 20;
    assert guess.is_hit
    guess1 = @game.register_guess_value 30;
    assert guess1.is_hit
    guess2 = @game.register_guess_at '4', 'A'
    assert guess2.is_hit
  end

end