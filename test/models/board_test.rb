require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  setup do
    @board = Board.new(rows: 'A,B,C,D,E,F,G,H,I,J', columns: '1,2,3,4,5,6,7,8,9,10')
  end
  test 'row_headings returns the comma seperated list as an array'  do
    assert_equal ['A','B','C','D','E','F','G','H','I','J'], @board.row_headings
  end

  test 'col_headings returns the comma serperated list as an array' do
    assert_equal ['1','2','3','4','5','6','7','8','9','10'], @board.col_headings
  end

  test 'get_cell_value returns the proper value' do
    assert_equal 0, @board.get_cell_value('1', 'A')
    assert_equal 33, @board.get_cell_value('4', 'D')
    assert_equal 86, @board.get_cell_value('9', 'G')
    assert_equal 99, @board.get_cell_value('10', 'J') 
  end

  test 'get_cell_value returns nill for out of range values' do
    assert_nil @board.get_cell_value('out of range', 'A')
    assert_nil @board.get_cell_value('1', 'out of range')
    assert_nil @board.get_cell_value('out of range', 'out of range')
  end

  test 'get_cell returns the corresponding cell from the value' do
    assert_equal ['1','A'], @board.get_cell(0)
    assert_equal ['4','D'], @board.get_cell(33) 
    assert_equal ['9','G'], @board.get_cell(86)
    assert_equal ['10', 'J'], @board.get_cell(99)
  end

  test 'get_cell on a value out of range returns nil' do
    assert_nil @board.get_cell(-1)
    assert_nil @board.get_cell(100)
    assert_nil @board.get_cell(101)
  end

  test 'get_values_below returns the specified number of values below' do
    assert_equal [0,1,2,3,4], @board.get_values_below(0, 4)
    assert_equal [23,24,25], @board.get_values_below(23,2)
    assert_equal [85,86], @board.get_values_below(85,1)
  end

  test 'get_values_below returns the specified number of cells above when supplied a negative number' do
    assert_equal [5,4,3], @board.get_values_below(5, -2)
    assert_equal [89, 88, 87, 86, 85, 84, 83, 82], @board.get_values_below(89, -7)
  end

  test 'get_values_below returns nil if one of the cells is out of range' do 
    assert_nil @board.get_values_below(5,5)
    assert_nil @board.get_values_below(5, -6)
  end

  test 'get_values_right returns the specified number of values to the right' do
    assert_equal [0,10,20], @board.get_values_right(0,2)
    assert_equal [45,55,65,75,85,95], @board.get_values_right(45,5) 
  end

  test 'get_values_right returns the specified number of values to the left when number is negative' do
    assert_equal [20,10,0], @board.get_values_right(20,-2)
    assert_equal [77, 67,57,47,37,27], @board.get_values_right(77, -5)
  end

  test 'get_values_right returns nil if one of the cells is out of range' do
    assert_nil @board.get_values_right(80, 3)
    assert_nil @board.get_values_right(78, 9)
  end

end

