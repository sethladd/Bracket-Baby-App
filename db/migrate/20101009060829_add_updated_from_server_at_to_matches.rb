class AddUpdatedFromServerAtToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :updated_from_server_at, :timestamp
  end

  def self.down
  end
end
