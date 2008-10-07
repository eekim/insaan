class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer :organization_id, :person_id, :null => false
      t.boolean :current, :default => false
      t.string :title, :default => ""
      t.text :description, :default => ""
      t.datetime :start_date, :finish_date
      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
