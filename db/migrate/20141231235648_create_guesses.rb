class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.belongs_to :game, index: true
      t.integer :guess_value
      t.boolean :is_hit

      t.timestamps null: false
    end
    add_foreign_key :guesses, :games
  end
end
