class AddFirstDayAndLastDayToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :last_day, :date
    add_column :matches, :first_day, :date
  end

  def self.down
  end
end
