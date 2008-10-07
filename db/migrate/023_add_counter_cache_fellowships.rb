class AddCounterCacheFellowships < ActiveRecord::Migration
  def self.up
    add_column :people, :fellowships_count, :integer, :null => false, :default => 0

    # http://railscasts.com/episodes/23
    Person.reset_column_information
    Person.find(:all).each do |p|
      if p.fellowships.length != 0
        Person.update_counters p.id, :fellowships_count => p.fellowships.length
      end
   end
  end

  def self.down
    remove_column :people, :fellowships_count
  end
end
