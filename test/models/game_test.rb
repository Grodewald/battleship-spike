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
    assert_equal (cols.length * 3 + 5),  (game.get_cell_value cols[3], rows[5])
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

  test "get_guess_at teturns nill when the cell has not been guessed" do 
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

end