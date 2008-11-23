# == Schema Information
# Schema version: 43
#
# Table name: people
#
#  id                  :integer(11)     not null, primary key
#  first_name          :string(255)     default("")
#  last_name           :string(255)     default("")
#  middle_name         :string(255)     default("")
#  name_prefix         :string(255)     default("")
#  name_suffix         :string(255)     default("")
#  bday                :date            
#  gender              :string(1)       default("F")
#  updated_at          :datetime        
#  company_name        :string(255)     default("")
#  job_title           :string(255)     
#  created_at          :datetime        
#  user_id             :integer(11)     
#  primary_email_cache :string(255)     
#  primary_phone_cache :string(255)     
#  photos_count        :integer(11)     default(0), not null
#  fellowships_count   :integer(11)     default(0), not null
#  country_id          :integer(11)     
#  region_id           :integer(11)     
#  affiliation_id      :integer(11)     
#

class Person < ActiveRecord::Base
  has_many :addresses, :dependent => :destroy, :order => "preferred DESC"
  has_many :email_addresses, :dependent => :destroy, :order => "preferred DESC"
  has_many :phone_numbers, :dependent => :destroy, :order => "preferred DESC"
  has_many :fellowships, :dependent => :destroy
  has_many :websites, :dependent => :destroy, :order => "preferred DESC"
  has_many :im_addresses, :dependent => :destroy, :order => "preferred DESC"
  has_many :profile_notes, :dependent => :destroy
  
  # countries / regions
  belongs_to :country, :counter_cache => true
  belongs_to :region, :counter_cache => true
  
  # photos and documents
  has_many :photos, :dependent => :destroy, :order => "preferred DESC" # TODO: polymorph photo uploads for orgs, groups, etc
  has_many :documents, :as => :documentable, :dependent => :destroy, :order => "updated_at DESC"
  
  # events / trainings
  has_many :registrations
  has_many :activities, :through => :registrations, :source => :event, :order => "start_date DESC"

  # organizations / jobs
  has_many :jobs
  has_many :organizations, :through => :jobs, :order => "current DESC, start_date DESC"
  
  # competency
  has_and_belongs_to_many :competencies

  # validations
  validates_presence_of :first_name, :last_name
  validates_length_of :first_name, :last_name, :within => 2..50
  
  validates_associated :addresses
  validates_associated :email_addresses
  validates_associated :im_addresses
  validates_associated :phone_numbers
  validates_associated :websites
  
  # composed_of :tz, :class_name => 'TZInfo::Timezone', :mapping => %w(time_zone time_zone)

  # setting of sort caches
  before_save :set_sort_caches

  def full_name
    [name_prefix, first_name, middle_name, last_name, name_suffix].reject(&:blank?) * ' '
  end
  alias_method :name, :full_name

  def age
    now = Time.now
    return now.year - bday.year - (bday.to_time.change(:year => now.year) > now ? 1 : 0) 
  end
  
  # TODO: what defines person as active?
  def active?
    !activities.empty? && activities.first.finish_date > 1.year.ago
  end
  
  # find the first email marked as preferred to use as the primary email
  def primary_email
    email_addresses.find(:first, :conditions => {:preferred => true}) || email_addresses.first
  end

  # find the first phone number marked as preferred to use as the primary number
  def primary_phone
    phone_numbers.find(:first, :conditions => {:preferred => true}) || phone_numbers.first
  end

  # current job
   def current_job
     jobs.find(:first, :conditions => {:current => true}) || jobs.first
   end

  # avatar
  def avatar
    photos.find(:first, :conditions => { :preferred => true}) || photos.first
  end
  
  # search and filter methods (later combine for unified results)
  def self.filter(filter, sort, page, items_per_page)
    paginate(:per_page => items_per_page,
             :page => page,
             :include => [:fellowships],
             :conditions => filter,
             :order => sort
             )
  end

  def self.search(search, page, items_per_page)
    paginate(:per_page => items_per_page,
             :page => page,
             :conditions => ["(first_name LIKE ? OR middle_name LIKE ? OR last_name LIKE ?)",
                             "%#{search}%","%#{search}%","%#{search}%"],
             :order => "last_name ASC")
  end

  # new attribute methods
  def new_email_address_attributes=(email_address_attributes)
    email_address_attributes.each do |attributes|
      email_addresses.build(attributes)
    end
  end
  def new_phone_number_attributes=(phone_number_attributes)
    phone_number_attributes.each do |attributes|
      phone_numbers.build(attributes)
    end
  end
  def new_address_attributes=(address_attributes)
    address_attributes.each do |attributes|
      addresses.build(attributes)
    end
  end
  def new_website_attributes=(website_attributes)
    website_attributes.each do |attributes|
      websites.build(attributes)
    end
  end
  def new_im_address_attributes=(im_address_attributes)
    im_address_attributes.each do |attributes|
      im_addresses.build(attributes)
    end
  end
  
  # existing attributes
  after_update :save_addresses, :save_email_addresses, :save_im_addresses, :save_websites, :save_phone_numbers
  
  def existing_address_attributes=(address_attributes)
    addresses.reject(&:new_record?).each do |address|
      attributes = address_attributes[address.id.to_s]
      if attributes
        address.attributes = attributes
      else
        addresses.delete(address)
      end
    end
  end
  
  def save_addresses
    addresses.each do |address|
      address.save(false)
    end
  end

  def existing_email_address_attributes=(email_address_attributes)
    email_addresses.reject(&:new_record?).each do |email_address|
      attributes = email_address_attributes[email_address.id.to_s]
      if attributes
        email_address.attributes = attributes
      else
        email_addresses.delete(email_address)
      end
    end
  end
  
  def save_email_addresses
    email_addresses.each do |email_address|
      email_address.save(false)
    end
  end
  
  def existing_im_address_attributes=(im_address_attributes)
    im_addresses.reject(&:new_record?).each do |im_address|
      attributes = im_address_attributes[im_address.id.to_s]
      if attributes
        im_address.attributes = attributes
      else
        im_addresses.delete(im_address)
      end
    end
  end
  
  def save_im_addresses
    im_addresses.each do |im_address|
      im_address.save(false)
    end
  end
  
  def existing_phone_number_attributes=(phone_number_attributes)
    phone_numbers.reject(&:new_record?).each do |phone_number|
      attributes = phone_number_attributes[phone_number.id.to_s]
      if attributes
        phone_number.attributes = attributes
      else
        phone_numbers.delete(phone_number)
      end
    end
  end
  
  def save_phone_numbers
    phone_numbers.each do |phone_number|
      phone_number.save(false)
    end
  end

  def existing_website_attributes=(website_attributes)
    websites.reject(&:new_record?).each do |website|
      attributes = website_attributes[website.id.to_s]
      if attributes
        website.attributes = attributes
      else
        websites.delete(website)
      end
    end
  end
  
  def save_websites
    websites.each do |website|
      website.save(false)
    end
  end

  # private methods
  private

  def set_sort_caches
    self.primary_email_cache = primary_email.blank? ? '' : primary_email.email_address
    self.primary_phone_cache = primary_phone.blank? ? '' : primary_phone.phone_number
    self.job_title = current_job.blank? ? '' : current_job.title
    self.company_name = current_job.blank? ? '' : current_job.organization.name
  end

end
