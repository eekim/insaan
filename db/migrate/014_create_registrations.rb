class CreateRegistrations < ActiveRecord::Migration
  def self.up
    rename_table :training_contact, :registrations
    rename_column :registrations, :Contact_id, :person_id
    rename_column :registrations, :Training_id, :event_id
    rename_column :registrations, :Participation, :participation
    change_column :registrations, :participation, :string
    add_column :registrations, :notes, :text
    add_column :registrations, :is_organizer, :boolean, :default => false

    # convert participation "trainer/organizer" to boolean
    Registration.find(:all) do |r|
      if r.participation != nil && !r.participation.empty?
        if r.participation == "Trainer"
          r.is_organizer = true
        else
          r.is_organzier = false
        end
      else
        r.is_organizer = false
      end
    end
  end

  def self.down

  end
end
