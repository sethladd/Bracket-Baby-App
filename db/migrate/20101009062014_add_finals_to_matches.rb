class AddFinalsToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :finals, :boolean, :default => false
  end

  def self.down
  end
end
