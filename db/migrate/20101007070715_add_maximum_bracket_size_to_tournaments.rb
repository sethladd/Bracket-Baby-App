class AddMaximumBracketSizeToTournaments < ActiveRecord::Migration
  def self.up
    add_column :tournaments, :maximum_bracket_size, :integer, :default => 0
  end

  def self.down
  end
end
