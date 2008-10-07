class MigrateWebsites < ActiveRecord::Migration
  def self.up
    
    Person.find(:all).each do |p|
      if p.website != nil and !p.website.empty?
        w = Website.new
        w.site_url = p.website
        w.site_title = "Personal Site"
        w.person_id = p.id
        w.save
      end      
    end
    
    # drop website column in people
    remove_column :people, :website    
  end

  def self.down
    add_column :people, :website, :string, :default => ""
    webs = Website.find(:all).each do |w|
      w.destroy
    end
  end
end
