class ImportRegionDefaults < ActiveRecord::Migration
  def self.up

    down
    
    directory = File.join(RAILS_ROOT, "db", "dev_data")
    Fixtures.create_fixtures(directory, "regions")
    
  end

  def self.down
    Region.delete_all
  end
end
