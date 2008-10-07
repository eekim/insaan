class CreateProfileNotes < ActiveRecord::Migration
  def self.up
    create_table :profile_notes do |t|
      t.integer :person_id
      t.string :note_type
      t.text :body
      # t.timestamps #=> time/update info is stored in person
    end
  end

  def self.down
    drop_table :profile_notes
  end
end
