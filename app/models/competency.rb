# == Schema Information
# Schema version: 43
#
# Table name: competencies
#
#  id          :integer(11)     not null, primary key
#  name        :string(255)     default("")
#  description :string(255)     default("")
#  created_at  :datetime        
#  updated_at  :datetime        
#  permalink   :string(255)     
#

class Competency < ActiveRecord::Base
  
  has_and_belongs_to_many :people

#  has_permalink :name
 # def to_param
  #  permalink
 # end
  
end
