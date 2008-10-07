# == Schema Information
# Schema version: 43
#
# Table name: events
#
#  id          :integer(11)     not null, primary key
#  event_type  :string(255)     
#  institution :string(255)     
#  title       :string(255)     
#  city        :string(255)     
#  start_date  :datetime        
#  finish_date :datetime        
#  notes       :text            not null
#  country     :string(255)     
#

class Event < ActiveRecord::Base
  has_many :registrations
  has_many :attendees, :through => :registrations, :source => :person

  has_and_belongs_to_many :programs
  
  # TODO: define common event types (training, meeting, etc.)
end
