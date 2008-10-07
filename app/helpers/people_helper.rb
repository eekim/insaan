module PeopleHelper

  def login_name_and_roles(person)
    if person.user != nil
      login_name = person.user.login
      if person.user.roles != nil
        roles = person.user.roles.collect{|r| r.name.downcase }
        roles.flatten!
        roles_string = roles.reject(&:blank?) * ', '
        return login_name + " " + "(" + roles_string + ")"
      else
        return login_name
      end
    else
      return false
    end
  end

  def format_address(person)
    if person.addresses.first != nil
      street = person.addresses.first.street
      city_state = [person.addresses.first.city, person.addresses.first.state].reject(&:blank?) * ', '
      city_state_zip = [city_state, person.addresses.first.postal_code].reject(&:blank?) * ' '
      
      address = [street, city_state_zip, person.addresses.first.country_name].reject(&:blank?) * '<br />'

      return address
    else
      return false
    end
  end

  # form helpers
  def add_email_address_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :email_addresses, :partial => 'email_address' , :object => EmailAddress.new
    end
  end

  def add_phone_number_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :phone_numbers, :partial => 'phone_number' , :object => PhoneNumber.new
    end
  end

  def add_address_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :addresses, :partial => 'address' , :object => Address.new
    end
  end

  def add_website_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :websites, :partial => 'website' , :object => Website.new
    end
  end

  def add_im_address_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :im_addresses, :partial => 'im_address' , :object => ImAddress.new
    end
  end

  def add_competency_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :competencies, :partial => 'competency' , :object => Competency.new
    end
  end

  
end
