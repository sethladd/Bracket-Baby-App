class AddScoresToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :player1_score, :integer
    add_column :matches, :player2_score, :integer
  end

  def self.down
    remove_column :matches, :player1_score
    remove_column :matches, :player2_score
  end
end
