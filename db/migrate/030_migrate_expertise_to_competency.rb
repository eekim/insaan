class MigrateExpertiseToCompetency < ActiveRecord::Migration
  
  def self.up
    
    # get rid of this information
    drop_table :expertise
    drop_table :contact_expertise    
    
  end

  def self.down
    # never go back
  end
end
