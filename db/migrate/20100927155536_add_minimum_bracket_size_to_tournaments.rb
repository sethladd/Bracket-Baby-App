class AddMinimumBracketSizeToTournaments < ActiveRecord::Migration
  def self.up
    add_column :tournaments, :minimum_bracket_size, :integer
  end

  def self.down
    remove_column :tournaments, :minimum_bracket_size
  end
end
