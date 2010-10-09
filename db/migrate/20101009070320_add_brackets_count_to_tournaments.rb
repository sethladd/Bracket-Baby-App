class AddBracketsCountToTournaments < ActiveRecord::Migration
  def self.up
    add_column :tournaments, :brackets_count, :integer, :default => 0
  end

  def self.down
  end
end
