
require_relative '../../sections/admin/admin_dashboard'

class Dashboard < SitePrism::Page
  # welcome message
  element :message_welcome, '.helper'
  element :btn_continue, '.button-save'

  section :options, Sections::MenuOptions, '#navigation-bar'
  
end
