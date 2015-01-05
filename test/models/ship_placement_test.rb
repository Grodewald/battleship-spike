require 'test_helper'

class ShipPlacementTest < ActiveSupport::TestCase
  setup do
    @ship = Ship.new(name: 'Test Ship', size: 3)
    @board = Board.new(rows: 'A,B,C,D,E,F,G,H,I,J', columns: '1,2,3,4,5,6,7,8,9,10')
    @game = Game.new(name: 'Test Game', board: @board)
    @placement = @game.place_ship(@ship, 20, :horizontal )
  end 

  test 'ship_placement shoud start out with 0 hits' do 
    assert_equal 0, @placement.hits
  end

  test 'register_hit should increment hits by 1' do
    @placement.register_hit
    assert_equal 1, @placement.hits
    @placement.register_hit
    assert_equal 2, @placement.hits
  end

  test 'register_hit should stop incrementing when it reaches the ship\'s size' do
    @placement.register_hit
    @placement.register_hit
    @placement.register_hit
    assert_equal 3, @placement.hits
    @placement.register_hit
    assert_equal 3, @placement.hits
  end

  test 'is_sunk returns false when there are fewer hits than the ship\'s size' do 
    assert_not @placement.is_sunk
    @placement.register_hit
    assert_not @placement.is_sunk
    @placement.register_hit
    assert_not @placement.is_sunk
  end

  test 'is_sunk returns true when the hits equals the size of the ship' do
    @placement.register_hit
    @placement.register_hit
    @placement.register_hit
    assert @placement.is_sunk
  end

end

