# == Schema Information
# Schema version: 43
#
# Table name: addresses
#
#  id           :integer(11)     not null, primary key
#  person_id    :integer(11)     
#  preferred    :boolean(1)      
#  address_type :string(255)     default("")
#  street       :string(255)     default("")
#  city         :string(255)     default("")
#  state        :string(255)     default("")
#  postal_code  :string(255)     default("")
#  geocode      :string(255)     default("")
#  country_name :string(255)     default("")
#

class Address < ActiveRecord::Base
#   validates_presence_of :address_type
#   validates_presence_of :street
#   validates_presence_of :city
#   validates_presence_of :country

  belongs_to  :person

#  after_save {|record| record.person.save if record.person}
#  after_destroy {|record| record.person.save if record.person}
  
  TYPES = ['Work', 'Home', 'Mail', 'Other']

  protected

   def validate
     errors.add(nil, "The address can not be entirely blank") if (street.to_s + city.to_s + state.to_s + postal_code.to_s + country_name.to_s).strip.blank?
   end

end
