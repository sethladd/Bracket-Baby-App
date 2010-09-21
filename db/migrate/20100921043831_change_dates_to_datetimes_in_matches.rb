class ChangeDatesToDatetimesInMatches < ActiveRecord::Migration
  def self.up
    rename_column :matches, :first_day, :starts_at
    rename_column :matches, :last_day, :ends_at
    change_column :matches, :starts_at, :datetime
    change_column :matches, :ends_at, :datetime
  end

  def self.down
  end
end
