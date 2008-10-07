class CreateFellowships < ActiveRecord::Migration

  class Country < ActiveRecord::Base; end

  def self.up
    rename_table :program_contact, :fellowships
    rename_column :fellowships, :Program_id, :program_id
    rename_column :fellowships, :Contact_id, :person_id
    rename_column :fellowships, :Country_id, :country_id
    rename_column :fellowships, :Year, :year
    add_column :fellowships, :country, :string

    # get country name from country_id
    Fellowship.find(:all).each do |f|
      if f.country_id != nil && !f.country_id.empty?
        if c = Country.find_by_country_code(f.country_id)
          f.country = c.country_name
          f.save
        end
      end
    end

    # dont need country id
    remove_column :fellowships, :country_id

  end

  def self.down
    rename_table :fellowships, :program_contact
  end
end
