class AddMatchesCountToBrackets < ActiveRecord::Migration
  def self.up
    add_column :brackets, :matches_count, :integer, :default => 0
  end

  def self.down
  end
end