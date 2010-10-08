class AddMatchLengthToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :match_length, :integer
  end

  def self.down
  end
end
