require_relative '../../sections/admin/admin'


class Admin < SitePrism::Page

 section :options, Sections::MenuOptions, '#navigation-bar'
 section :main_menu, Sections::MainMenu, '.navigation-menu '
 element :dropdown, '.rbn-dropdown span.ng-binding'
 element :option_home, 'ul[class="rbn-dropdown-menu dropdown-menu-right"] > li:nth-child(7) > a'
 element :admin_title, '.webapp-admin-page-header'
 element :load, 'div#loading-bar'



  def goto_settings_admin
    while options.has_admin_setup? == false do
      puts "waiting for admin setup"
    end
      options.admin_setup.click
  end



end 