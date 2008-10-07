# == Schema Information
# Schema version: 43
#
# Table name: phone_numbers
#
#  id                :integer(11)     not null, primary key
#  person_id         :integer(11)     
#  preferred         :boolean(1)      
#  phone_number_type :string(255)     default("")
#  phone_number      :string(255)     default("")
#

class PhoneNumber < ActiveRecord::Base
  validates_presence_of :phone_number_type
  validates_presence_of :phone_number

  belongs_to :person

#   after_save {|record| record.person.save if record.person}
#   after_destroy {|record| record.person.save if record.person}

  TYPES = ['Work', 'Mobile', 'Personal', 'Home', 'Fax', 'Other']
end
