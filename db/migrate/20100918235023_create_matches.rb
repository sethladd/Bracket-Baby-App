class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.belongs_to :participant1, :participant2, :tournament, :winner
      t.datetime :finished_at
      t.timestamps
    end
    [:participant1, :participant2, :tournament, :winner].each do |column|
      add_index :matches, column.to_s+"_id"
    end
  end

  def self.down
    drop_table :matches
  end
end
