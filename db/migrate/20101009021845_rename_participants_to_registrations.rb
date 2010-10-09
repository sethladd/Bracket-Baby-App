class RenameParticipantsToRegistrations < ActiveRecord::Migration
  def self.up
    rename_table :participants, :registrations
    rename_column :tournaments, :participants_count, :registrations_count
  end

  def self.down
    rename_column :tournaments, :registrations_count, :participants_count
    rename_table :registrations, :participants
  end
end
