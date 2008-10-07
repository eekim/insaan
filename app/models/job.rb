# == Schema Information
# Schema version: 43
#
# Table name: jobs
#
#  id              :integer(11)     not null, primary key
#  organization_id :integer(11)     not null
#  person_id       :integer(11)     not null
#  current         :boolean(1)      
#  title           :string(255)     default("")
#  description     :text            
#  start_date      :datetime        
#  finish_date     :datetime        
#  created_at      :datetime        
#  updated_at      :datetime        
#

class Job < ActiveRecord::Base
  belongs_to :person
  belongs_to :organization
  
  after_save {|record| record.person.save if record.person}
  after_destroy {|record| record.person.save if record.person}
end
