class AddNumberOfRoundsToBrackets < ActiveRecord::Migration
  def self.up
    add_column :brackets, :number_of_rounds, :integer
  end

  def self.down
    remove_column :brackets, :number_of_rounds
  end
end
