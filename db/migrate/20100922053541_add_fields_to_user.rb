class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    [:time_zone, :first_name, :last_name].each do |column|
      add_column :users, column, :string
    end
  end

  def self.down
  end
end
