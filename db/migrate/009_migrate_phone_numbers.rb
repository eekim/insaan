class MigratePhoneNumbers < ActiveRecord::Migration
  def self.up
    # loop through people and pull to create phone numbers
    Person.find(:all).each do |p|

      if p.telHome != nil && !p.telHome.empty?
        n = PhoneNumber.new
        n.person_id = p.id
        n.phone_number_type = "home"
        n.phone_number = p.telHome
        n.save
      end
      if p.telOffice1 != nil && !p.telOffice1.empty?
        n = PhoneNumber.new
        n.person_id = p.id
        n.phone_number_type = "work"
        n.phone_number = p.telOffice1
        n.save
      end
      if p.telOffice2 != nil && !p.telOffice2.empty?
        n = PhoneNumber.new
        n.person_id = p.id
        n.phone_number_type = "work"
        n.phone_number = p.telOffice2
        n.save
      end
      if p.telOffice3 != nil && !p.telOffice3.empty?
        n = PhoneNumber.new
        n.person_id = p.id
        n.phone_number_type = "work"
        n.phone_number = p.telOffice3
        n.save
      end
      if p.telMobile1 != nil && !p.telMobile1.empty?
        n = PhoneNumber.new
        n.person_id = p.id
        n.phone_number_type = "mobile"
        n.phone_number = p.telMobile1
        n.save
      end
      if p.telMobile2 != nil && !p.telMobile2.empty?
        n = PhoneNumber.new
        n.person_id = p.id
        n.phone_number_type = "mobile"
        n.phone_number = p.telMobile2
        n.save
      end
      if p.telFax != nil && !p.telFax.empty?
        n = PhoneNumber.new
        n.person_id = p.id
        n.phone_number_type = "fax"
        n.phone_number = p.telFax
        n.save
      end
    end

    # set preffered bit
    # loop through people after phones imported
    # use p.id to find(:first...) and set to preffered
    Person.find(:all).each do |p|
      if n = PhoneNumber.find(:first, :conditions => ["person_id = ?", p.id])
        n.preferred = true
        n.save

        # also update primary_email_cache
        p.primary_phone_cache = n.phone_number
        p.save
      end
    end

    # drop unneeded columns from people
    remove_column :people, :telHome
    remove_column :people, :telOffice1
    remove_column :people, :telOffice2
    remove_column :people, :telOffice3
    remove_column :people, :telMobile1
    remove_column :people, :telMobile2
    remove_column :people, :telFax

  end

  def self.down
  end
end
