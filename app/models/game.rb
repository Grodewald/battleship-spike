class Game < ActiveRecord::Base
  @@columns = [ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']
  @@rows = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']

  def Columns
    @@columns
  end

  def Rows
    @@rows
  end
  
end
