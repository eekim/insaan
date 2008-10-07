class ConvertImagesToPhotosModel < ActiveRecord::Migration
  def self.up
    # rename columns and tables for convention
    rename_column :images, :ImageCaption, :caption
    rename_column :images, :ImageName, :filename

    rename_table :contact_image, :images_people
    rename_column :images_people, :Contact_id, :person_id
    rename_column :images_people, :Image_id, :image_id

    #find old images, convert to photos
    Person.find(:all).each do |p|
      if p.images != nil
        p.images.each do |i|
          puts 'found - ' + p.first_name + ' ' + i.filename

          # import into photos and set relationships
          image_file = File.join(RAILS_ROOT, 'tmp', 'fellows-images-bk', i.filename)
          @photo = Photo.new(:filename => image_file,
                             :content_type => 'image/jpg',
                             :temp_path => image_file,
                             :preferred => true )

          p.photos << @photo
        end
      end
    end

    # drop old tables
    drop_table :images_people
    drop_table :images

  end

  def self.down
    rename_column :images, :caption, :ImageCaption
    rename_column :images, :filename, :ImageName
    rename_table :images_people, :contact_image
    rename_column :contact_image, :person_id, :Contact_id
    rename_column :contact_image, :image_id, :Image_id
  end
end
