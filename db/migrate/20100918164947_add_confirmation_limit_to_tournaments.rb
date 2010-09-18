class AddConfirmationLimitToTournaments < ActiveRecord::Migration
  def self.up
    add_column :tournaments, :confirmation_limit, :integer, :default => 0
  end

  def self.down
    remove_column :tournaments, :confirmation_limit
  end
end
