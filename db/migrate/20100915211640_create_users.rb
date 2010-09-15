class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :identifier_url, :email
      t.timestamps
    end
    add_index :users, :identifier_url, :unique => true
  end

  def self.down
    drop_table :users
  end
end
