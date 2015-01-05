class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy
  has_many :ship_placements,  dependent: :destroy
  belongs_to :board

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
    validate_value_in_range(val) ? 
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

    def validate_value_in_range(val)
      max_value = (columns.length * rows.length - 1)
      (val >= 0 and val <= max_value)
    end

    def validate_ship_placement(ship, top_left_value, orientation) 
      ( validate_ship_on_board(ship, top_left_value, orientation) and
        validate_ship_does_not_intersect_others(ship, top_left_value, orientation))
    end

    def validate_ship_does_not_intersect_others(ship, top_left_value, orientation)
      ship_placements.each do |sp|
        if (  get_ship_placement_values(sp.top_left_value, sp.orientation, sp.ship.size) & 
              get_ship_placement_values(top_left_value, orientation, ship.size)).any?
              return false
        end
      end
      true
    end

    def validate_ship_on_board(ship, top_left_value, orientation)
      ship_values = get_ship_placement_values(top_left_value, orientation, ship.size)
      #used for vertical check -- if last is greater than first it must be off the board
      ship_mods = ship_values.map{ |val| val%rows.length }
      (validate_value_in_range (ship_values.last)) and 
      (validate_value_in_range (ship_values.first)) and
      (ship_mods.first <= ship_mods.last)
    end

    def validate_range(col, row) 
      columns.index(col) and rows.index(row)
    end

    def get_ship_placement_values(top_left_value, orientation, ship_size)
      inc = orientation.to_s == 'horizontal' ? rows.length : 1
      (0..(ship_size-1)).to_a.map{ |val| (val * inc + top_left_value)}
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
