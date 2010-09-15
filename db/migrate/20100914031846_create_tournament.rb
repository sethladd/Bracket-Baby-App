class CreateTournament < ActiveRecord::Migration
  def self.up
    create_table :tournaments do |t|
      t.string :name
      t.text :description
      t.datetime :started_at
      t.timestamps
    end
    add_index :tournaments, :started_at
  end

  def self.down
  end
end
