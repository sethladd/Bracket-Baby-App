class AddExternalGameUriToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :external_game_uri, :string
  end

  def self.down
    remove_column :matches, :external_game_uri
  end
end
