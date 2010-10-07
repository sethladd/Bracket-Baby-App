class AddEndedAtToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :ended_at, :timestamp
  end

  def self.down
    remove_column :matches, :ended_at
  end
end
