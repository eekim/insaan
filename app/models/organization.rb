# == Schema Information
# Schema version: 43
#
# Table name: organizations
#
#  id          :integer(11)     not null, primary key
#  name        :string(255)     default("")
#  url         :string(255)     default("")
#  description :text            
#  created_at  :datetime        
#  updated_at  :datetime        
#

class Organization < ActiveRecord::Base
  has_many :jobs
  has_many :employees, :through => :jobs, :source => :person
end
