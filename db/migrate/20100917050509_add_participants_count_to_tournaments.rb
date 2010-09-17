class AddParticipantsCountToTournaments < ActiveRecord::Migration
  def self.up
    add_column :tournaments, :participants_count, :integer, :default => 0
  end

  def self.down
    remove_column :tournaments, :participants_count
  end
end
