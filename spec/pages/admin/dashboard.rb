

class Dashboard < SitePrism::Page
  # welcome message
  element :message_welcome, '.helper'
  element :btn_continue, '.button-save'

  #admi menu
  element :admin_dasboard, 'a[ui-sref="admin.dashboard"]'
  element :admin_setup, 'a[ui-sref="admin.setup"]'
  element :admin_e911, 'a´[ui-sref="admin.e911"]'
  element :admin_reports, 'a[ui-sref="admin.reporting-analytics"]'
  element :admin_announcements, 'a[ui-sref="admin.announcement-center"]'
  element :admin_account_billing, 'a[ui-sref="admin.account-billing-information"]'
  element :admin_support

  
end
