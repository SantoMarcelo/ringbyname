require_relative '../../sections/admin/admin'


class Admin < SitePrism::Page

 section :options, Sections::MenuOptions, '#navigation-bar'
 section :main_menu, Sections::MainMenu, '.navigation-menu '
 element :dropdown, '.rbn-dropdown'
 element :option_home, 'ul[class="rbn-dropdown-menu dropdown-menu-right"] > li:nth-child(7) > a'
 element :admin_title, '.webapp-admin-page-header'

end