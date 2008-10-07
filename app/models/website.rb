# == Schema Information
# Schema version: 43
#
# Table name: websites
#
#  id         :integer(11)     not null, primary key
#  person_id  :integer(11)     
#  site_title :string(255)     default("")
#  site_url   :string(255)     default("")
#  preferred  :boolean(1)      
#

class Website < ActiveRecord::Base
  validates_presence_of :site_title
  validates_presence_of :site_url

  belongs_to :person

  before_save :transform_url

#   after_save {|record| record.person.save if record.person}
#   after_destroy {|record| record.person.save if record.person}

  private

  def transform_url
    unless site_url.blank? || site_url =~ /^http:\/\//
      self.site_url = "http://#{site_url}"
    end
  end

end
