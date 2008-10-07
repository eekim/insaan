# == Schema Information
# Schema version: 43
#
# Table name: countries
#
#  id           :integer(11)     not null, primary key
#  name         :string(255)     
#  people_count :integer(11)     
#  created_at   :datetime        
#  updated_at   :datetime        
#

class Country < ActiveRecord::Base

  validates_presence_of :name
  
  has_many :regions, :dependent => :destroy
  has_many :people
  
end
