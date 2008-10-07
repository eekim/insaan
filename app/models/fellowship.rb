# == Schema Information
# Schema version: 43
#
# Table name: fellowships
#
#  id         :integer(11)     not null, primary key
#  program_id :integer(11)     
#  person_id  :integer(11)     
#  year       :string(4)       
#  country    :string(255)     
#

class Fellowship < ActiveRecord::Base
  validates_presence_of :year
  validates_presence_of :country

  belongs_to :person, :counter_cache => true
  belongs_to :program

  # collections for use in forms as selection lists
  f = find(:all)

  yrs = f.collect{|y| [y.year.to_i, y.year.to_i] if y.year != nil && y.year.to_i != 0}.to_a
  #yrs.flatten!
  yrs.uniq!
  yrs.compact!
  yrs.sort!
  yrs.insert(0,["all years",nil])
  YEARS = yrs

  cntries = f.collect{|c| [c.country, c.country] if c.country != nil }
  cntries.uniq!
  cntries.compact!
  cntries.sort!
  cntries.insert(0, ["all countries",nil])
  COUNTRIES = cntries

end
