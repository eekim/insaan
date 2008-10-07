class CreateWebsites < ActiveRecord::Migration
  def self.up
    create_table :websites do |t|
      t.column "person_id", :integer
      t.column "site_title", :string, :default => ""
      t.column "site_url", :string, :default => ""
      t.column "preferred", :boolean, :default => false
    end
  end

  def self.down
    drop_table :websites
  end
end
