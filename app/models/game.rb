class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy
  @@rows = { 'A' => 0, 'B' => 1, 'C' => 2, 'D' => 3, 'E' => 4, 
                          'F' => 5, 'G' => 6, 'H' => 7, 'I' => 8, 'J' => 9 }

  @@columns = {  '1' => 0, '2' => 1, '3' => 2, '4' => 3, '5' => 4,  
                      '6' => 5, '7' => 6, '8' => 7, '9' => 8, '10' => 9 }

  def columns
    @@columns.keys
  end

  def rows
    @@rows.keys
  end

  def get_cell_value(col, row)
    validate_range(col, row) ? 
      (@@columns[col] * @@columns.length + @@rows[row])  : nil
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
    if validate_range col, row  then
      get_guess_at(col, row) ||
      guesses.build(guess_value: get_cell_value(col,row), is_hit: false)
    else
      nil
    end
    
  end

  private 

  def validate_range(col, row) 
    @@columns[col] and @@rows[row]
  end
  
end
