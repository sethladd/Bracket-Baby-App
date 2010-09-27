class AddMatchLengthToTournaments < ActiveRecord::Migration
  def self.up
    add_column :tournaments, :match_length, :integer
  end

  def self.down
    remove_column :tournaments, :match_length
  end
end
