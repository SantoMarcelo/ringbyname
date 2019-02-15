
require_relative '../../../sections/admin/dashboard/dashboard'
require_relative '../../admin/admin'

class Dashboard < Admin
  # welcome message
  element :message_welcome, '.helper'
  element :btn_continue, '.button-save'

  
  def goto_home
    self.dropdown.click
    self.option_home.click
  end

  # def goto_settings
  #   find(options.admin_setup).click
  # end

end
  