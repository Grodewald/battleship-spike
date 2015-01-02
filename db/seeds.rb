# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Ship START
Ship.delete_all

carrier = Ship.create!(name: 'Aircraft Carrier', size: 5)
battleship = Ship.create!(name: 'Battleship', size: 4)
destroyer = Ship.create!(name: 'Destroyer', size: 3)
sub = Ship.create!(name: 'Submarine', size: 3)
pt = Ship.create!(name: 'PT Cruiser', size: 2)

#Ship END

# Game START
Game.delete_all

game = Game.create!(name: "A Sample In Progress Game")
game.place_ship(carrier, 0, :vertical).save
game.place_ship(battleship, 24, :horizontal).save
game.place_ship(destroyer, 83, :vertical).save
game.place_ship(sub, 58, :horizontal).save
game.place_ship(pt, 89, :horizontal).save

# Game END

