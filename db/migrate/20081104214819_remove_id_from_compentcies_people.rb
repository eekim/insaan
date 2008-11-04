class RemoveIdFromCompentciesPeople < ActiveRecord::Migration
  def self.up
    remove_column :competencies_people, :id
  end

  def self.down
    add_column :competencies_people, :id, :primary_key
  end
end
