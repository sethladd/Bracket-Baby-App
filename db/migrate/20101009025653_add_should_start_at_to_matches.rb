class AddShouldStartAtToMatches < ActiveRecord::Migration
  def self.up
    rename_column :matches, :starts_at, :should_start_at
    rename_column :matches, :ends_at, :should_end_at
  end

  def self.down
  end
end
