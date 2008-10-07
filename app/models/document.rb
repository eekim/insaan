# == Schema Information
# Schema version: 43
#
# Table name: documents
#
#  id                :integer(11)     not null, primary key
#  title             :string(255)     default("")
#  description       :text            
#  size              :integer(11)     
#  content_type      :string(255)     
#  filename          :string(255)     
#  documentable_id   :integer(11)     
#  documentable_type :string(255)     
#  created_at        :datetime        
#  updated_at        :datetime        
#

class Document < ActiveRecord::Base
  belongs_to :documentable, :polymorphic => true
  
  has_attachment(:content_type => ['application/msword', 'application/rtf', 
                                   'application/x-rtf', 'application/richtext', 
                                   'text/plain', 'application/vnd.oasis.opendocument.text',
                                   'application/pdf'],
                 :storage      => :file_system,
                 :max_size     => 10.megabytes,
                 :path_prefix  => "documents/#{table_name}"
                 )
  validates_as_attachment
  
  validates_presence_of :title
  
end
