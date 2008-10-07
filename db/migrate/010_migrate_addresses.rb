class MigrateAddresses < ActiveRecord::Migration
  
  class Country < ActiveRecord::Base; end

  def self.up
    # fix country table schema
    # rename to countries
    rename_table :country, :countries
    # rename countrycode to id and countryname to country_name
    rename_column :countries, :CountryCode, :country_code
    change_column :countries, :country_code, :string, { :limit => 2 } # this doesn't work to remove the primary_key, need to delete it in the ihp_backup.sql file
    rename_column :countries, :CountryName, :country_name
    remove_column :countries, :CountryNotes
    remove_column :countries, :isCountryPackardFocus
    add_column :countries, :id, :primary_key

    # go through people
    Person.find(:all).each do |p|

      # if there is part of a home address defined grab it and set up relationship
      if p.homeAddr != nil && !p.homeAddr.empty?
        a = Address.new
        a.person_id = p.id
        a.address_type = "home"
        a.street = p.homeAddr
        a.city = p.homeCity unless p.homeCity == nil || p.homeCity.empty?
        a.state = p.homeState unless p.homeState == nil || p.homeState.empty?
        a.postal_code = p.homeCode unless p.homeCode == nil || p.homeCode.empty?
        # get country name by matching to country table
        if p.homeCountry != nil && !p.homeCountry.empty?
          if c = Country.find_by_country_code(p.homeCountry)
            a.country_name = c.country_name
          end
        end

        a.save
      end

      # if there is part of an other address defined grab it and set up relationship
      if p.otherAddr != nil && !p.otherAddr.empty?
        a = Address.new
        a.person_id = p.id
        a.address_type = "other"
        a.street = p.otherAddr
        a.city = p.otherCity unless p.otherCity == nil || p.otherCity.empty?
        a.state = p.otherState unless p.otherState == nil || p.otherState.empty?
        a.postal_code = p.otherCode unless p.otherCode == nil || p.otherCode.empty?
        # get country name by matching to country table
        if p.otherCountry != nil && !p.otherCountry.empty?
          if c = Country.find_by_country_code(p.otherCountry)
            a.country_name = c.country_name
          end
        end

        a.save
      end
    end # end people loop

    # get rid of now useless people columns dealing with address
    remove_column :people, :homeAddr
    remove_column :people, :homeCity
    remove_column :people, :homeState
    remove_column :people, :homeCountry
    remove_column :people, :homeCode
    remove_column :people, :otherAddr
    remove_column :people, :otherCity
    remove_column :people, :otherState
    remove_column :people, :otherCountry
    remove_column :people, :otherCode
  end

  def self.down
  end
end
