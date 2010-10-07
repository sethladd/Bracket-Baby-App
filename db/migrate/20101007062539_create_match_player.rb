class CreateMatchPlayer < ActiveRecord::Migration
  def self.up
    remove_column :matches, :participant1_id
    remove_column :matches, :participant2_id
    remove_column :matches, :player1_score
    remove_column :matches, :player2_score
    
    create_table :match_players do |t|
      t.belongs_to :match
      t.belongs_to :user
      t.integer :score, :default => 0
      t.timestamps
    end
    
    add_index :match_players, :match_id
    add_index :match_players, :user_id
    
    add_column :matches, :match_player_count, :integer, :default => 0
  end

  def self.down
  end
end
