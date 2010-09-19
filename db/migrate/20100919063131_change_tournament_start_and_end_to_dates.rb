class ChangeTournamentStartAndEndToDates < ActiveRecord::Migration
  def self.up
    change_column :tournaments, :starts_at, :date
    change_column :tournaments, :ends_at, :date
    rename_column :tournaments, :starts_at, :starts_on
    rename_column :tournaments, :ends_at, :ends_on
  end

  def self.down
  end
end
