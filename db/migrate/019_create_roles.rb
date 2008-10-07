class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.column :name, :string
    end
    # create default roles
    Role.create(:name => 'Administrator')
    Role.create(:name => 'Editor')
    # index for searching on username
    add_index :users, :login

    # add an enabled toggle for user accounts
    # will require an admin interface for enabling/disabling
    add_column :users, :enabled, :boolean, :default => false, :null => false

    # last login to track activity
    add_column :users, :last_login_at, :datetime
  end

  def self.down
    drop_table :roles
    remove_index :users, :login
    remove_column :users, :enabled
    remove_column :users, :last_login_at
  end
end
