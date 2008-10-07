class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string :title, :default => ""
      t.text :description, :default => ""
      # for attachment fu
      t.integer :size
      t.string :content_type, :filename
      # polymorph
      t.integer :documentable_id
      t.string :documentable_type
      # timestamps
      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
