# == Schema Information
# Schema version: 43
#
# Table name: programs
#
#  id         :integer(11)     not null, primary key
#  title      :string(255)     
#  abbr       :string(255)     
#  notes      :text            
#  updated_at :datetime        
#  created_at :datetime        
#

class Program < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :abbr

  has_and_belongs_to_many :events

  # get collection of abbrs and ids for drop down selection lists
  ABBRS = find(:all).collect {|p| [p.abbr, p.id]}.insert(0, ["all programs",nil])

end
