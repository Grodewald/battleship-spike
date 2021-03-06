class ShipPlacement < ActiveRecord::Base
  belongs_to :ship
  belongs_to :game

  def register_hit
    self.hits < ship.size ?
      self.hits += 1 : self.hits
    self.update(hits: self.hits)
  end 

  def is_sunk
    ship.size <= self.hits
  end

end
