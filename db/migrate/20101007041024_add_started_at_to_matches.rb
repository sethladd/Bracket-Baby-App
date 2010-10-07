class AddStartedAtToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :started_at, :timestamp
  end

  def self.down
    remove_column :matches, :started_at
  end
end
