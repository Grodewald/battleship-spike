class CreateGamesPlayersJoinTable < ActiveRecord::Migration
  def change
    create_table :games_players, id: false do |t|
      t.integer :game_id
      t.integer :player_id
    end

    add_index :games_players, :game_id
    add_index :games_players, :player_id

  end
end
