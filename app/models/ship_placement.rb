class ShipPlacement < ActiveRecord::Base
  belongs_to :ship
  belongs_to :game
end
