class AddBoardToGame < ActiveRecord::Migration
  def change
    add_reference :games, :board, index: true
    add_foreign_key :games, :boards
  end
end
