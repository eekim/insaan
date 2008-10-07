class ChangeDefaultGenderFemale < ActiveRecord::Migration
  def self.up
    change_column :people, :gender, :string, :limit => 1, :default => "F"
  end

  def self.down
  end
end
