class AddPermalinkToRegion < ActiveRecord::Migration
  def self.up
    add_column :regions, :permalink, :string
    
    # poplulate field
    Region.find(:all).each(&:save)    
  end

  def self.down
    remove_column :regions, :permalink
  end
end
