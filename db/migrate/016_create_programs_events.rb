class CreateProgramsEvents < ActiveRecord::Migration
  def self.up
    rename_table :training_program, :programs_events
    rename_column :programs_events, :Training_id, :event_id
    rename_column :programs_events, :Program_id, :program_id
  end

  def self.down
  end
end
