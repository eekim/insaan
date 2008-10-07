class CreateEmailAddresses < ActiveRecord::Migration
  def self.up
    create_table :email_addresses do |t|
      t.integer :person_id
      t.boolean :preferred, :default => false
      t.string :email_type, :email_address, :default => ""
    end
  end

  def self.down
    drop_table :email_addresses
  end
end
