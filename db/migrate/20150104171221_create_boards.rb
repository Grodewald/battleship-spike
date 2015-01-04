class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :rows
      t.string :columns

      t.timestamps null: false
    end
  end
end
