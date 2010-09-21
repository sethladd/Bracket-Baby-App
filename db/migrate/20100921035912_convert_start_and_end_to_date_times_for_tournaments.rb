class ConvertStartAndEndToDateTimesForTournaments < ActiveRecord::Migration
  def self.up
    change_column :tournaments, :starts_on, :datetime
    change_column :tournaments, :ends_on, :datetime
    rename_column :tournaments, :starts_on, :starts_at
    rename_column :tournaments, :ends_on, :ends_at
    rename_column :tournaments, :starts_on_timezone, :starts_at_timezone
    rename_column :tournaments, :ends_on_timezone, :ends_at_timezone
  end

  def self.down
  end
end
