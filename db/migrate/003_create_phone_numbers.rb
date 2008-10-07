class CreatePhoneNumbers < ActiveRecord::Migration
  def self.up
    create_table :phone_numbers do |t|
      t.integer :person_id
      t.boolean :preferred, :default => false
      t.string :phone_number_type, :phone_number, :default => ""
    end

  end

  def self.down
    drop_table :phone_numbers
  end
end
