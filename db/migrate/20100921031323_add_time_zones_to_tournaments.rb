class AddTimeZonesToTournaments < ActiveRecord::Migration
  def self.up
    add_column :tournaments, :starts_on_timezone, :string
    add_column :tournaments, :ends_on_timezone, :string
  end

  def self.down
  end
end
