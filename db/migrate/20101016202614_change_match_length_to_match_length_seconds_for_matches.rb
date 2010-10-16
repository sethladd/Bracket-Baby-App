class ChangeMatchLengthToMatchLengthSecondsForMatches < ActiveRecord::Migration
  def self.up
    rename_column :matches, :match_length, :match_length_seconds
  end

  def self.down
  end
end
