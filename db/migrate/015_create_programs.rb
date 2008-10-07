class CreatePrograms < ActiveRecord::Migration
  def self.up
    rename_table :program, :programs
    rename_column :programs, :name, :title
    add_column :programs, :updated_at, :datetime
    add_column :programs, :created_at, :datetime

    Program.find(:all).each do |p|
      p.updated_at = Time.now
      p.created_at = Time.now
      p.save
    end
  end

  def self.down

  end
end
