class CreateShipPlacements < ActiveRecord::Migration
  def change
    create_table :ship_placements do |t|
      t.references :ship, index: true
      t.belongs_to :game, index: true
      t.integer :top_left_value
      t.string :orientation

      t.timestamps null: false
    end
    add_foreign_key :ship_placements, :ships
    add_foreign_key :ship_placements, :game
  end
end
