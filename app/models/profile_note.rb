# == Schema Information
# Schema version: 43
#
# Table name: profile_notes
#
#  id        :integer(11)     not null, primary key
#  person_id :integer(11)     
#  note_type :string(255)     
#  body      :text            
#

class ProfileNote < ActiveRecord::Base
  validates_presence_of :note_type
  validates_presence_of :body

  belongs_to :person

  after_save {|record| record.person.save if record.person}
  after_destroy {|record| record.person.save if record.person}

  TYPES = ['About Me', 'Education', 'Work Experience', 'Other']

end
