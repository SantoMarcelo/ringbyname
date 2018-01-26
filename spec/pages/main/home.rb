require_relative '../../sections/main/menu'
require_relative '../../sections/main/home'
require_relative '../../sections/main/contact_card'

class Home < SitePrism::Page
  element :dropdown, '.dropdown-user-menu.dropdown'
  element :option_admin, 'a[ui-sref="admin.dashboard"]'
  element :option_logout, 'a[ui-sref="auth.logout"]'
  element :user_status, 'button[class="btn s12 ng-binding btn-online"]'

  section :home_menu, Sections::MainMenu, '.nav-middle-top'
  section :contact, Sections::Contact, '#contact-list'

    
  element :message, 'div[class="noty_message"] > span'

  def menu_access
    dropdown.click
  end

  def goto_admin
    menu_access
    option_admin.click
  end

  def access_crm
    home_menu.crm.click
  end

  def select_contact(contact)
    wait_until_contact_visible
    sleep(3)
    self.contact.contact_list.each do |u|
      if u.text.include?(contact[:name])
        u.click
        break
      end
    end
  end

  def logout
    dropdown.click
    option_logout.click
  end

end
