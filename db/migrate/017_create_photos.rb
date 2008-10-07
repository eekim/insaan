class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.column :person_id, :integer
      t.column :title, :string, :default => ""
      t.column :body, :text, :default => ""
      t.column :created_at, :datetime
      t.column :preferred, :boolean, :default => false

      # the following columns are required for attachment_fu
      t.column :content_type, :string, :limit => 100
      t.column :filename, :string, :limit => 255
      t.column :path, :string, :limit => 255
      t.column :parent_id, :integer
      t.column :thumbnail, :string, :limit => 255
      t.column :size, :integer
      t.column :width, :integer
      t.column :height, :integer
    end
    add_column :people, :photos_count, :integer, :null => false, :default => 0
  end

  def self.down
    drop_table :photos
    remove_column :people, :photos_count
  end
end
