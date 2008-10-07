class ImportDefaultFfiliations < ActiveRecord::Migration
  def self.up

    down
    
    directory = File.join(RAILS_ROOT, "db", "dev_data")
    Fixtures.create_fixtures(directory, "affiliations")
  end

  def self.down
    Affiliation.delete_all
  end
end
