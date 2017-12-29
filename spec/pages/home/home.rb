require_relative '../../sections/home/menu'
require_relative '../../sections/home/home'

class Home < SitePrism::Page
    element :home_menu, '.dropdown-user-menu.dropdown'
    element :option_admin, 'a[ui-sref="admin.dashboard"]'
    element :user_status, 'button[class="btn s12 ng-binding btn-online"]'
    
    section :home_menu, Sections::MainMenu, '.nav-middle-top'
    section :contact, Sections::Contact, '#contact-list'
    

    def menu_access 
        self.home_menu.click
    end

    def goto_admin
        self.menu_access
        self.option_admin.click    
           
    end

    def access_crm
        self.home_menu.crm.click
    end

    def select_contact(contact)
        self.wait_until_contact_visible
        sleep(3)
        self.contact.contact_list.each do |u|
            if u.text.include?(contact[:name])
                u.click
                break
            end    
        end
    end


end
