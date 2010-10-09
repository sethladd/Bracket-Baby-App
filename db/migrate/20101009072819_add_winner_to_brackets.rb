class AddWinnerToBrackets < ActiveRecord::Migration
  def self.up
    add_column :brackets, :winner_id, :integer
    add_index :brackets, :winner_id
  end

  def self.down
  end
end
