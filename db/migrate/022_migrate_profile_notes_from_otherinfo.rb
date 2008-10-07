class MigrateProfileNotesFromOtherinfo < ActiveRecord::Migration

  # dummy model
  class Otherinfo < ActiveRecord::Base; end

  def self.up
    # renaming for help
     rename_table :otherinfo_contact, :otherinfos
     rename_column :otherinfos, :Contact_id, :contact
    # loop through persons
    Person.find(:all).each do |p|
      other_info = Otherinfo.find_by_contact(p.id)
      if other_info
        puts other_info.contact
        if other_info.education != nil && !other_info.education.empty?
          puts other_info.education
          edu_note = ProfileNote.create(:note_type => "Education",
                                        :body => other_info.education)
          p.profile_notes << edu_note
        end
        if other_info.professional != nil && !other_info.professional.empty?
          puts other_info.professional
          work_note = ProfileNote.create(:note_type => "Work Experience",
                                         :body => other_info.professional)
          p.profile_notes << work_note
        end
      end
    end

    # don't need old table anymore
    drop_table :otherinfos

  end

  def self.down
    rename_table :otherinfos, :otherinfo_contact
    rename_column :otherinfo_contact, :contact, :Contact_id
  end
end
