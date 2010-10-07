class AddMatchPlayersCountToMatch < ActiveRecord::Migration
  def self.up
    remove_column :matches, :match_player_count
    add_column :matches, :match_players_count, :integer, :default => 0
  end

  def self.down
  end
end
