class CreateEvents < ActiveRecord::Migration

  class Country < ActiveRecord::Base; end

  def self.up
    rename_table :training, :events
    rename_column :events, :type, :event_type
    change_column :events, :event_type, :string
    rename_column :events, :begin, :start_date
    rename_column :events, :end, :finish_date
    change_column :events, :start_date, :datetime
    change_column :events, :finish_date, :datetime
    rename_column :events, :country, :country_id
    add_column :events, :country, :string

    # get country name from country_id
    Event.find(:all).each do |t|
      if t.country_id != nil && !t.country_id.empty?
        if c = Country.find_by_country_code(t.country_id)
          t.country = c.country_name
          t.save
        end
      end
    end

    remove_column :events, :country_id

  end

  def self.down
    rename_table :events, :training
    rename_column :training, :training_type, :type
    rename_column :training, :start_date, :begin
    rename_column :training, :finish_date, :end
    remove_column :training, :country
    rename_column :training, :country_id, :country
  end
end
