require_relative '../../sections/home/menu'
require_relative '../../sections/home/home'

class Home < SitePrism::Page
  element :dropdown, '.dropdown-user-menu.dropdown'
  element :option_admin, 'a[ui-sref="admin.dashboard"]'
  element :user_status, 'button[class="btn s12 ng-binding btn-online"]'

  section :home_menu, Sections::MainMenu, '.nav-middle-top'
  section :contact, Sections::Contact, '#contact-list'

  elements :opportunity_list, '.crm-card-list > div > table > tbody > tr'

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

  def validate_oppo_list(opportunity)
    opportunity_list.each do |u|
      puts u.text
      if u.text.include?(opportunity[:name]) && u.text.include?(opportunity[:status]) && u.text.include?(opportunity[:price]) && u.text.include?(opportunity[:probability])
        puts 'true'
        return true
      end
    end
    puts 'false'
    return false
  end
end
