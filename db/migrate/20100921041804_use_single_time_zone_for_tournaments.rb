class UseSingleTimeZoneForTournaments < ActiveRecord::Migration
  def self.up
    rename_column :tournaments, :starts_at_timezone, :time_zone
    remove_column :tournaments, :ends_at_timezone
  end

  def self.down
  end
end
