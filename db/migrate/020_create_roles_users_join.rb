class CreateRolesUsersJoin < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false do |t|
      t.column :role_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
    end

    # need to reload Person model here?
    Person.reset_column_information
    # Default administrator
    admin_person = Person.create(:first_name => 'Adam',
                                 :last_name => 'Thompson',
                                 :title => 'Administrator',
                                 :company_name => 'GIIP')
    admin_person.user = User.create(:login => 'adam',
                             :email => 'adam@giip.org',
                             :password => 'admin', :password_confirmation => 'admin'
                             )
    admin_email = EmailAddress.create(:email_address => 'adam@giip.org',
                               :preferred => true,
                               :email_type => 'Work')
    admin_phone = PhoneNumber.create(:phone_number => "831.212.8397",
                               :phone_number_type => "Work",
                               :preferred => true)

    admin_person.email_addresses << admin_email
    admin_person.phone_numbers << admin_phone

    admin_role = Role.find_by_name('Administrator')
    edit_role = Role.find_by_name('Editor')

    admin_person.user.roles << admin_role
    admin_person.user.roles << edit_role

  end

  def self.down
    u = User.find_by_login('admin')
    u.person.destroy if u.person != nil
    u.destroy if u != nil
    drop_table :roles_users
  end
end
