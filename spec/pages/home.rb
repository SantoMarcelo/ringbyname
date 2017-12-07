
class Home < SitePrism::Page
    element :home_menu, '.dropdown-user-menu.dropdown'
    element :option_admin, 'a[ui-sref="admin.dashboard"]'
    element :user_status, 'button[class="btn s12 ng-binding btn-online"]'
    
    

    def menu_access 
        self.home_menu.click
    end

    def goto_admin
        self.menu_access
        self.option_admin.click    
           
    end


end
