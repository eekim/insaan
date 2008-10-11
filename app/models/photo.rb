# == Schema Information
# Schema version: 43
#
# Table name: photos
#
#  id           :integer(11)     not null, primary key
#  person_id    :integer(11)     
#  title        :string(255)     default("")
#  body         :text            
#  created_at   :datetime        
#  preferred    :boolean(1)      
#  content_type :string(100)     
#  filename     :string(255)     
#  path         :string(255)     
#  parent_id    :integer(11)     
#  thumbnail    :string(255)     
#  size         :integer(11)     
#  width        :integer(11)     
#  height       :integer(11)     
#

require 'action_controller'
require 'action_controller/test_process.rb'

class Photo < ActiveRecord::Base
  belongs_to :person, :counter_cache => true

  has_attachment(:storage => :file_system,
                 :resize_to => '320x240>',
                 :thumbnails => { :thumb => [150,150], :large => [96,96], :medium => [64,64], :small => [48,48], :tiny => [32,32] },
                 :max_size => 3.megabytes,
                 :content_type => :image,
                 :processor => 'Rmagick')

  validates_as_attachment

  # this processes the person record so the caches and sorts can be run
  after_save {|record| record.person.save if record.person}
  after_destroy {|record| record.person.save if record.person}
  
  # overload resize image
  # see: http://toolmantim.com/article/2006/9/12/generating_cropped_thumbnails_with_acts_as_attachment
  def resize_image(img, size)
    size = size.first if size.is_a?(Array) && size.length == 1 && !size.first.is_a?(Fixnum)
    if size.is_a?(Fixnum) || (size.is_a?(Array) && size.first.is_a?(Fixnum))
      size = [size, size] if size.is_a?(Fixnum)
      #img.thumbnail!(*size)
      # fix from: http://pastie.org/58467
      size[0] == size[1] ? img.crop_resized!(*size) : img.thumbnail!(*size)
      # This elsif extends
    elsif size.is_a?(Hash)
      dx, dy = size[:crop].split(':').map(&:to_f)
      w, h = (img.rows * dx / dy), (img.columns * dy / dx)
      img.crop!(::Magick::CenterGravity, [img.columns, w].min, [img.rows, h].min)
      size = size[:size]
      w2, h2 = size.split('x').map(&:to_f)
      img.resize!(w2,h2)
    else
      img.change_geometry(size.to_s) { image.resize!(cols<1 ? 1 : cols, rows<1 ? 1 : rows) }
    end
    img.strip! unless attachment_options[:keep_profile]
    temp_paths.unshift write_to_temp_file(img.to_blob)
    #self.temp_path = write_to_temp_file(img.to_blob)
  end

#         def resize_image(img, size)
#           size = size.first if size.is_a?(Array) && size.length == 1 && !size.first.is_a?(Fixnum)
#           if size.is_a?(Fixnum) || (size.is_a?(Array) && size.first.is_a?(Fixnum))
#             size = [size, size] if size.is_a?(Fixnum)
#             img.thumbnail!(*size)
#           else
#             img.change_geometry(size.to_s) { |cols, rows, image| image.resize!(cols<1 ? 1 : cols, rows<1 ? 1 : rows) }
#           end
#           img.strip! unless attachment_options[:keep_profile]
#           temp_paths.unshift write_to_temp_file(img.to_blob)
#         end
  
  
end
