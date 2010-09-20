class AddPrecedingMatchToMatches < ActiveRecord::Migration
  def self.up
    2.times do |i|
      i += 1
      add_column :matches, "preceding_match#{i}", :integer
      add_index :matches, "preceding_match#{i}"
    end
  end

  def self.down
  end
end
