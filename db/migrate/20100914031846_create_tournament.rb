class CreateTournament < ActiveRecord::Migration
  def self.up
    create_table :tournaments do |t|
      t.string :name
      t.text :description
      t.datetime :starts_at
      t.datetime :ends_at
      t.timestamps
    end
    add_index :tournaments, :starts_at
    add_index :tournaments, :ends_at
  end

  def self.down
  end
end
