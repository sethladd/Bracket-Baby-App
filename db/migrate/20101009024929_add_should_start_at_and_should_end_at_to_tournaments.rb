class AddShouldStartAtAndShouldEndAtToTournaments < ActiveRecord::Migration
  def self.up
    rename_column :tournaments, :starts_at, :should_start_at
    rename_column :tournaments, :ends_at, :should_end_at
  end

  def self.down
  end
end
