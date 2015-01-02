class AddHitsToShipPlacement < ActiveRecord::Migration
  def change
    add_column :ship_placements, :hits, :integer
  end
end
