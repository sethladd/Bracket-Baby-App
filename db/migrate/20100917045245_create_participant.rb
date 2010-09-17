class CreateParticipant < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.belongs_to :user
      t.belongs_to :tournament
      t.timestamps
    end
    add_index :participants, :user_id
    add_index :participants, :tournament_id
    add_index :participants, [:user_id, :tournament_id], :unique => true
  end

  def self.down
    drop_table :participants
  end
end
