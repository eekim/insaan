class ImportDefaultCountries < ActiveRecord::Migration
  def self.up
    
    down
    
    # import from yaml file for defaults
    directory = File.join(RAILS_ROOT, "db", "dev_data")
    Fixtures.create_fixtures(directory, "countries")
    
  end

  def self.down
    Country.delete_all
  end
end
