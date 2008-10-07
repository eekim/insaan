# == Schema Information
# Schema version: 43
#
# Table name: email_addresses
#
#  id            :integer(11)     not null, primary key
#  person_id     :integer(11)     
#  preferred     :boolean(1)      
#  email_type    :string(255)     default("")
#  email_address :string(255)     default("")
#

class EmailAddress < ActiveRecord::Base
  validates_presence_of :email_type
  validates_presence_of :email_address

  belongs_to :person

  # this processes the person record so the primary_email_cache can be updated
#  after_save {|record| record.person.save if record.person}
#  after_destroy {|record| record.person.save if record.person}

  TYPES = ['Work', 'Personal', 'Other']

end
