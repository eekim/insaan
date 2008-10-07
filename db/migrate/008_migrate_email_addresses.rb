class MigrateEmailAddresses < ActiveRecord::Migration
  def self.up
    # import from people (email1, email2, email3) => (home, work, other)
    Person.find(:all).each do |p|
      if p.email1 != nil and !p.email1.empty?
        e = EmailAddress.new
        e.email_type = "work"
        e.email_address = p.email1
        e.person_id = p.id
        e.save
      end
      if p.email2 != nil and !p.email2.empty?
        e = EmailAddress.new
        e.email_type = "home"
        e.email_address = p.email2
        e.person_id = p.id
        e.save
      end
      if p.email3 != nil and !p.email3.empty?
        e = EmailAddress.new
        e.email_type = "other"
        e.email_address = p.email3
        e.person_id = p.id
        e.save
      end
    end

    # set preffered bit
    # loop through people after emails imported
    # use p.id to find(:first...) and set to preffered
    Person.find(:all).each do |p|
      if e = EmailAddress.find(:first, :conditions => ["person_id = ?", p.id])
        e.preferred = true
        e.save

        # also update primary_email_cache
        p.primary_email_cache = e.email_address
        p.save
      end
    end

    # drop unneeded columns from people
    remove_column :people, :email1
    remove_column :people, :email2
    remove_column :people, :email3    
  end

  def self.down
  end
end
