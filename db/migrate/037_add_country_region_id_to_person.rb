class AddCountryRegionIdToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :country_id, :integer
    add_column :people, :region_id, :integer
  end

  def self.down
    remove_column :people, :country_id
    remove_column :people, :region_id
  end
end
