
require_relative '../../sections/admin/admin_dashboard'

class Dashboard < SitePrism::Page
  # welcome message
  element :message_welcome, '.helper'
  element :btn_continue, '.button-save'

  section :options, Sections::MenuOptions, '#navigation-bar'

  element :dropdown, '.rbn-dropdown'
  element :option_home, 'ul[class="rbn-dropdown-menu dropdown-menu-right"] > li:nth-child(7) > a'
  
def goto_home
  self.dropdown.click
  self.option_home.click

end

end
