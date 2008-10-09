# == Schema Information
# Schema version: 43
#
# Table name: regions
#
#  id           :integer(11)     not null, primary key
#  name         :string(255)     
#  country_id   :integer(11)     
#  people_count :integer(11)     
#  created_at   :datetime        
#  updated_at   :datetime        
#  permalink    :string(255)     
#

class Region < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :country_id
  
  belongs_to :country
  has_many :people

  # define permalink
  #has_permalink :country_region_name
  def to_param
    "#{self.id}-#{name.to_safe_uri}"
  end
  
  def country_region_name
    [self.country.name, name].join('-')
  end
  
  def total_leaders
    self.people.size
  end
  
  def total_female_leaders
    total = 0
    self.people.each do |p|
      if p.gender == "F"
        total += 1
      end
    end
    return total
  end
  
  def total_male_leaders
    total = 0
    self.people.each do |p|
      if p.gender == "M"
        total += 1
      end
    end
    return total
  end
  
end
