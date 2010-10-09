class AddWinnerToMatchPlayers < ActiveRecord::Migration
  def self.up
    add_column :match_players, :winner, :boolean, :default => false
  end

  def self.down
  end
end
