class CreateCountries < ActiveRecord::Migration
  def self.up

    # get rid of old table countries
    down
    
    create_table :countries do |t|
      t.string :name
      t.integer :people_count 
      t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
