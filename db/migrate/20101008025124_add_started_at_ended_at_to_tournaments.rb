class AddStartedAtEndedAtToTournaments < ActiveRecord::Migration
  def self.up
    add_column :tournaments, :started_at, :timestamp
    add_column :tournaments, :ended_at, :timestamp
  end

  def self.down
  end
end
