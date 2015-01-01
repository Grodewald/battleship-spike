class Ship < ActiveRecord::Base
  has_many :ship_placements, dependent: :destroy

  ORIENTATIONS = [ :horizontal, :vertical]
end
