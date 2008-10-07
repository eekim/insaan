class CreateImAddresses < ActiveRecord::Migration
  def self.up
    create_table :im_addresses do |t|
      t.column "person_id", :integer
      t.column "preferred", :boolean, :default => false
      t.column "im_type", :string, :default => ""
      t.column "im_address", :string, :default => ""
    end
  end

  def self.down
    drop_table :im_addresses
  end
end
