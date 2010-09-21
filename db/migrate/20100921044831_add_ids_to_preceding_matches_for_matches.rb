class AddIdsToPrecedingMatchesForMatches < ActiveRecord::Migration
  def self.up
    rename_column :matches, :preceding_match1, :preceding_match1_id
    rename_column :matches, :preceding_match2, :preceding_match2_id
  end

  def self.down
  end
end
