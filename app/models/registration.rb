# == Schema Information
# Schema version: 43
#
# Table name: registrations
#
#  id            :integer(11)     not null, primary key
#  event_id      :integer(11)     
#  person_id     :integer(11)     
#  participation :string(255)     
#  notes         :text            
#  is_organizer  :boolean(1)      
#

class Registration < ActiveRecord::Base

  belongs_to :person
  belongs_to :event

  after_save {|record| record.person.save if record.person}
  after_destroy {|record| record.person.save if record.person}

end
