# == Schema Information
# Schema version: 43
#
# Table name: affiliations
#
#  id         :integer(11)     not null, primary key
#  name       :string(255)     
#  created_at :datetime        
#  updated_at :datetime        
#

class Affiliation < ActiveRecord::Base
  
  validates_presence_of :name
  
  has_many :people 
  
end
