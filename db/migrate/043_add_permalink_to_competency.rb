class AddPermalinkToCompetency < ActiveRecord::Migration
  def self.up
    add_column :competencies, :permalink, :string
    
    Competency.find(:all).each(&:save)
  end

  def self.down
    remove_column :competencies, :permalink
  end
end
