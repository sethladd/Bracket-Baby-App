class DropTimeZoneFromTournaments < ActiveRecord::Migration
  def self.up
    remove_column :tournaments, :time_zone
  end

  def self.down
  end
end
