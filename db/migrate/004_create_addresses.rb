class CreateAddresses < ActiveRecord::Migration

  def self.up
    create_table :addresses do |t|
      t.column "person_id", :integer
      t.column "preferred", :boolean, :default => false
      t.column "address_type", :string, :default => ""
      t.column "street", :string, :default => ""
      t.column "city", :string, :default => ""
      t.column "state", :string, :default => ""
      t.column "postal_code", :string, :default => ""
      t.column "geocode", :string, :default => ""
      t.column "country_name", :string, :default => ""
    end

  end

  def self.down
    drop_table :addresses
  end
end
