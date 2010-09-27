class AddRoundToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :round, :integer
  end

  def self.down
    remove_column :matches, :round
  end
end
