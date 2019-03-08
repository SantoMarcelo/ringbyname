require_relative '../../sections/main/menu'
require_relative '../../sections/main/home'
require_relative '../../sections/main/contacts/contact_card'

class Home < SitePrism::Page
  element :my_caller_id, '.column-left .dropdown-title'
  element :dropdown, '.column-right .dropdown-user-menu.dropdown'
  element :title, '.column-middle-container'
  element :message, '.noty_message .noty_text'

  #element :option_admin, 'a[ui-sref="admin.dashboard"]'
 # element :option_logout, 'a[ui-sref="auth.logout"]'
  element :user_status, 'button[class="btn s12 ng-binding btn-online"]'
  
 
  section :home_features, Sections::FeaturesMenu, '.nav-middle-top'
  section :contact, Sections::Contact, '.contacts'
  section :dropdown_menu , Sections::HomeMenu, 'ul.dropdown-menu'
 
    
  element :message, 'div[class="noty_message"] > span'

  def check_user_status
    while has_user_status? == false
      puts"waiting for status.."
    end
  end

  def menu_access
    dropdown.click
  end

  def goto_admin
    menu_access
    dropdown_menu.goto_admin.click
  end

  def access_crm
    home_features.crm.click
  end

  def select_contact(contact)
    wait_until_contact_visible
    sleep 1
    self.contact.contact_list.each do |u|
      if u.text.include?(contact[:full_name])
        u.click
        break
      end
    end
  end

  def validate_contact_list(contact)
    wait_until_contact_visible
    sleep 1
    self.contact.contact_list.each do |u|
      
      if u.text.include?(contact[:full_name])
        return true
      end
     end
    return false
  end

  def logout
    dropdown.click
    dropdown_menu.logout.click
  end

  def select_group_filter(group_name)
    self.contact.group_filter_list.each do |item|
      if item.text.include?(group_name)
         item.click
         break
      end
    end
  end

end
