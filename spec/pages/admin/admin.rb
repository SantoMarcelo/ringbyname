require_relative '../../sections/admin/admin'


class Admin < SitePrism::Page

 section :options, Sections::MenuOptions, '#navigation-bar'
 element :dropdown, '.rbn-dropdown'
 element :option_home, 'ul[class="rbn-dropdown-menu dropdown-menu-right"] > li:nth-child(7) > a'

end