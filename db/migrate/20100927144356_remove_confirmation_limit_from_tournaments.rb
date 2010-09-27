class RemoveConfirmationLimitFromTournaments < ActiveRecord::Migration
  def self.up
    remove_column :tournaments, :confirmation_limit
  end

  def self.down
    add_column :tournaments, :confirmation_limit, :integer, :default => 0
  end
end
