class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy
  has_many :ship_placements,  dependent: :destroy
  belongs_to :board
  has_and_belongs_to_many :players

  def columns
    board.col_headings
  end

  def rows
    board.row_headings
  end

  def get_cell_value(col, row)
    board.get_cell_value(col, row)
  end

  def has_cell_been_guessed(col, row)
    validate_range(col, row) ?
      ( guesses.map { |guess| guess.guess_value }.include? get_cell_value col, row) :
      nil
  end

  def get_guess_at(col, row)
    guesses.select { |guess| guess.guess_value == get_cell_value(col, row) }[0]
  end

  def register_guess_at(col, row)
    (val = get_cell_value(col, row)) ? 
      register_guess_value(val) :
      nil
  end

  def register_guess_value(val)
    board.is_val_in_range(val) ? 
      ( (guesses.select{ |guess| guess.guess_value == val }[0]) ||
        guesses.build(guess_value: val, is_hit: determine_if_guess_is_hit(val)) ) :
      nil
  end

  def place_ship(ship, top_left_value, orientation)
    validate_ship_placement(ship, top_left_value, orientation) ?
      ship_placements.build(top_left_value: top_left_value, orientation: orientation, ship: ship, hits: 0) :
      nil
  end

  private 

    def validate_ship_placement(ship, top_left_value, orientation) 
      placement = get_ship_placement_values(top_left_value, orientation, ship.size)
      if (!placement)
        return false
      end
      ship_placements.each do |sp|
        if (  get_ship_placement_values(sp.top_left_value, sp.orientation, sp.ship.size) &
              placement).any?
          return false
        end
      end
      true
    end

    def validate_range(col, row) 
      columns.index(col) and rows.index(row)
    end

    def get_ship_placement_values(top_left_value, orientation, ship_size)
      ( orientation.to_s == 'horizontal' ? 
        board.get_values_right(top_left_value, ship_size -1 ) :
        board.get_values_below(top_left_value, ship_size -1))
    end 

    def determine_if_guess_is_hit(val)
      ship_placements.each do |sp|
        if get_ship_placement_values(sp.top_left_value, sp.orientation, sp.ship.size).include? val
          sp.register_hit
          return true
        end
      end
      false
    end
  
end
