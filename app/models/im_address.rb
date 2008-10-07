# == Schema Information
# Schema version: 43
#
# Table name: im_addresses
#
#  id         :integer(11)     not null, primary key
#  person_id  :integer(11)     
#  preferred  :boolean(1)      
#  im_type    :string(255)     default("")
#  im_address :string(255)     default("")
#

class ImAddress < ActiveRecord::Base
  validates_presence_of :im_type
  validates_presence_of :im_address

  belongs_to :person

#   after_save {|record| record.person.save if record.person}
#   after_destroy {|record| record.person.save if record.person}

  TYPES = ['AIM', 'IRC', 'Google Talk', 'Jabber', 'MSN', 'Skype', 'Yahoo', 'Gizmo', 'Other']

end
