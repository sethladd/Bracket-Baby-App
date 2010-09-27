class CreateBrackets < ActiveRecord::Migration
  def self.up
    create_table :brackets do |t|
      t.belongs_to :tournament
      t.timestamps
    end
    add_index :brackets, :tournament_id
    
    remove_index :matches, :tournament_id
    remove_column :matches, :tournament_id
    add_column :matches, :bracket_id, :integer
    add_index :matches, :bracket_id
  end

  def self.down
    drop_table :brackets
  end
end
