class MigrateJobsFromPerson < ActiveRecord::Migration
  
  # dummy class to pull stuff from orgs
  class Org < ActiveRecord::Base; end
  
  def self.up

    # change name of title in person
    rename_column :people, :title, :job_title
    Person.reset_column_information
    
    people = Person.find :all
    
    for person in people
      
      # if company_name is there create organization
      if !person.company_name.blank?     
        # check if already in organizations
        if org = Organization.find(:first, :conditions => ['name = ?', person.company_name])
          # set person to organization through job
          puts "found existing: #{person.company_name}"
        # if not a repeat create new entry
        else 
          org = Organization.new(:name => person.company_name)
          if oldorg = Org.find(:first, :conditions => ['org_name = ?',person.company_name])
            puts "found old: #{oldorg.org_name} \n"
            if !oldorg.orgWebsite.blank?
              org.url = oldorg.orgWebsite
            end
            if !oldorg.orgNotes.blank?
              org.description = oldorg.orgNotes
            end
          end
          org.save!
        end 
        
        # org done, now create job
        job = Job.new(:organization_id => org.id,
                      :person_id => person.id,
                      :title => person.job_title || "N/A",
                      :current => true)
        job.save!
      else
        puts "did not find company_name \n"
      end
    end # end for
    
    # drop orgs and org_contacts
    
  end

  def self.down
    # roll back 2 more to drop jobs/orgs
    #orgs = Organization.find :all
    #orgs.each { |o| o.destroy }
    rename_column :people, :job_title, :title
  end
end
