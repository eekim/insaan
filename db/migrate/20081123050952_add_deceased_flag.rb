class AddDeceasedFlag < ActiveRecord::Migration
  def self.up
    add_column :people, :is_deceased, :boolean, :default => false
  end

  def self.down
    remove_column :people, :is_deceased 
  end
end
