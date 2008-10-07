require 'active_record/fixtures'

class ImportAndMigrateCompetencies < ActiveRecord::Migration
  def self.up
    
    down
    
    # import from yaml file for defaults
    directory = File.join(RAILS_ROOT,"db", "dev_data")
    Fixtures.create_fixtures(directory, "competencies")
    
  end

  def self.down
    Competency.delete_all
  end
end
