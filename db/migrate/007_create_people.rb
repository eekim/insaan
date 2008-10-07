class CreatePeople < ActiveRecord::Migration

  class Org < ActiveRecord::Base; end
  class OrgContact < ActiveRecord::Base; end
  class LoginContact < ActiveRecord::Base; end

  def self.up
    rename_table :contact, :people
    rename_column :people, :prefix, :name_prefix
    change_column :people, :name_prefix, :string, { :default => "" }
    rename_column :people, :suffix, :name_suffix
    change_column :people, :name_suffix, :string, { :default => "" }
    rename_column :people, :firstName, :first_name
    change_column :people, :first_name, :string, { :default => "" }
    rename_column :people, :middleName, :middle_name
    change_column :people, :middle_name, :string, { :default => "" }
    rename_column :people, :lastName, :last_name
    change_column :people, :last_name, :string, { :default => "" }
    add_column :people, :company_name, :string, { :default => "" } # need to pull from old schema (org via org_contact)
    add_column :people, :title, :string, { :default => "" }        # need to pull from old schema (org_contact)
    # add_column :people, :time_zone, :string, { :default => "" }
    add_column :people, :created_at, :datetime                     # set to Time.now
    rename_column :people, :touched, :updated_at
    change_column :people, :updated_at, :datetime, { :default => nil }
    add_column :people, :user_id, :integer                         # need to pull from old schema (login_contact)
    add_column :people, :primary_email_cache, :string              # will be updated using a after save observer
    add_column :people, :primary_phone_cache, :string              # will be updated using a after save observer

    # from joyent connector
    # + renamed table contact => people    create_table :people do |t|
    # +      t.column "name_prefix", :string, :default => ""
    # +      t.column "first_name", :string, :default => ""
    # +      t.column "middle_name", :string, :default => ""
    # +      t.column "last_name", :string, :default => ""
    # +      t.column "name_suffix", :string, :default => ""
    # - not going to add this at the moment       t.column "nickname", :string, :default => ""
    # +      t.column "company_name", :string, :default => ""
    # +      t.column "title", :string, :default => ""
    # +      t.column "time_zone", :string, :default => ""
    # - going to use a separate "notes" model with a many-to-many relationship      t.column "notes", :text
    # +      t.column "created_at", :datetime
    # + renamed touched and fixed default value      t.column "updated_at", :datetime
    # - don't know what to do with this yet      t.column "organization_id", :integer
    # + need to pull from login      t.column "user_id", :integer
    # - what does the person_type refer to?     # t.column "person_type", :string
    # +      t.column "primary_email_cache", :string
    # +      t.column "primary_phone_cache", :string
    #     end

    # 1) rename tables to fit conventions for easy conversion
    rename_table :org, :orgs
    rename_column :orgs, :orgName, :org_name
    rename_table :org_contact, :org_contacts
    rename_column :org_contacts, :Contact_id, :contact_id
    rename_column :org_contacts, :Org_id, :org_id
    rename_table :login_contact, :login_contacts
    rename_column :login_contacts, :Login_id, :login_id
    rename_column :login_contacts, :Contact_id, :contact_id

    # 2) loop through people
    Person.find(:all).each do |p|
      # get company_name and title
      if c = OrgContact.find_by_contact_id(p.id)
        # get title
        if c.title != nil && !c.title.empty?
          p.title = c.title
        else
          p.title = ""
        end

        # get company_name
        if o = Org.find(c.org_id)
          if o.org_name != nil && !o.org_name.empty?
            p.company_name = o.org_name
          else
            p.company_name = ""
          end
        end
      end # end company_name and title fishing

      # set created_at to now
      p.created_at = Time.now

      # get user_id from login_contact
      if u = LoginContact.find_by_contact_id(p.id)
        if u.login_id != nil
          p.user_id = u.login_id.to_i
        end
      end

      p.save
    end # end looping through people

  end

  def self.down
    drop_table :people
  end
end
