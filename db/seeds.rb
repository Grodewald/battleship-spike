# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Ship START
Ship.delete_all

Ship.create!(name: 'Aircraft Carrier', size: 5)
Ship.create!(name: 'Battleship', size: 4)
Ship.create!(name: 'Destroyer', size: 3)
Ship.create!(name: 'Submarine', size: 3)
Ship.create!(name: 'PT Cruiser', size: 2)

#Ship END

