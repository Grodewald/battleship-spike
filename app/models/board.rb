class Board < ActiveRecord::Base
  
  def row_headings
    rows.split(',')
  end

  def col_headings
    columns.split(',')
  end

  def get_cell_value(col, row)
    (col_index = col_headings.index(col)) and (row_index = row_headings.index(row)) ?
      (col_index * row_headings.length) + row_index : nil
  end

  def get_cell(val)
    is_val_in_range(val) ?
      [col_headings[val/row_headings.length], row_headings[val%row_headings.length]] :
      nil
  end

  def get_values_below(val, count)
    last_val = val%row_headings.length + count 
    (last_val >= 0 and last_val < row_headings.length and is_val_in_range(val)) ? 
      (val < (val + count ) ? (val..(val + count)).to_a : ((val+count)..val).to_a.reverse) :
      nil
  end

  def get_values_right(val, count)
    ary = (val < (val + count * row_headings.length)) ?
      (val..(count * row_headings.length + val)).step(row_headings.length).to_a :
      ((val + (count * row_headings.length)..val).step(row_headings.length).to_a.reverse)
    (is_val_in_range(ary.last) and is_val_in_range(ary.first)) ? ary : nil
  end

  def is_val_in_range(val)
      (val >= 0 and val <= max_value)       
  end

  private 

    def max_value
      col_headings.length * row_headings.length - 1
    end
end
