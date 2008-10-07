class FixDbErrorsAndIndices < ActiveRecord::Migration
  def self.up
    # rails (well rake) is throwing this error:
    # binary columns cannot have a default value: "0"
    change_column :login_temp, :login_temp_done, :boolean, :default => false
    # binary columns cannot have a default value: "1"
    change_column :country, :isCountryPackardFocus, :boolean, :default => false

    # new problem: Mysql::Error: BLOB/TEXT column 'responsible' used in key specification without a key length: CREATE  INDEX `responsible` ON `org_contacts` (`responsible`)
    remove_index :org_contact, :name => :title
    remove_index :org_contact, :name => :responsible
    # new problem: Mysql::Error: BLOB/TEXT column 'professional' used in key specification without a key length: CREATE  INDEX `professional` ON `otherinfo_contact` (`professional`)
    remove_index :otherinfo_contact, :name => :professional
    remove_index :otherinfo_contact, :name => :education
    remove_index :otherinfo_contact,  :name => :Contact_id

    # lets just drop the whole lot of indexes that i'm not using
    remove_index :org, :name => :orgNotes
    remove_index :org, :name => :orgWebsite
    remove_index :org, :name => :orgName

    remove_index :program_contact, :name => :Program_id
    remove_index :program_contact, :name => :Contact_id
    remove_index :program_contact, :name => :Country
    remove_index :program_contact, :name => :Year

    remove_index :images, :name => :ImageCaption
    remove_index :contact_image,  :name => :Contact_id
    remove_index :contact_image,  :name => :Image_id
    remove_index :login_contact, :name=> :Login_id
    remove_index :login_group, :name=> :login_id
    remove_index :login_temp, :name=> :group_id
    remove_index :mentor_contact,  :name => :Mentor_id
    remove_index :mentor_contact,  :name => :Mentoree_id
    remove_index :mentor_contact,  :name => :Note
    remove_index :org_contact,  :name => :Contact_id
    remove_index :org_contact,  :name => :Org_id
    remove_index :contact, :name => :name
    remove_index :training_program,  :name => :Training_id
    remove_index :training_program,  :name => :Program_id
    remove_index :training_contact,  :name => :Training_id
    remove_index :training_contact,  :name => :Contact_id
    remove_index :training,  :name => :country
    remove_index :training,  :name => :type
    remove_index :training, :name=> :begin
    remove_index :training, :name => :institution
    remove_index :country, :name => :isCountryPackardFocus
    remove_index :country, :name => :CountryNotes

    # other clean up
    drop_table :contact_image_seq
    drop_table :note_contact
    drop_table :story
    drop_table :story_contact
    drop_table :story_image
  end

  def self.down
  end
end
