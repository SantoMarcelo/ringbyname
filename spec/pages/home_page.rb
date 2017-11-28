
class Home < SitePrism::Page
    element :home_menu, '.dropdown-user-menu.dropdown'
    

    def menu_access 
        self.home_menu.click
    end

end
