class AddConfirmedToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :confirmed, :boolean, :default => false
  end

  def self.down
    remove_column :registrations, :confirmed
  end
end
