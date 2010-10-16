class ChangeMatchLengthToMatchLengthSecondsForTournaments < ActiveRecord::Migration
  def self.up
    rename_column :tournaments, :match_length, :match_length_seconds
  end

  def self.down
  end
end
