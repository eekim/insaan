class CreateCompetencies < ActiveRecord::Migration
  def self.up
    create_table :competencies do |t|
      t.string :name, :description, :default => ""
      t.timestamps
    end
    
    create_table :competencies_people do |t|
      t.integer :competency_id, :person_id
    end
    
  end

  def self.down
    drop_table :competencies
    drop_table :competencies_people
  end
end
