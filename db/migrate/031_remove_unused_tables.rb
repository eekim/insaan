class RemoveUnusedTables < ActiveRecord::Migration
  def self.up

    drop_table :groups
    drop_table :login
    drop_table :login_contacts
    drop_table :login_group
    drop_table :login_temp
#    drop_table :logs
    drop_table :mentor_contact
    drop_table :org_contacts
    drop_table :orgs
    
  end

  def self.down
    # never look back
  end
end
