
module Sections

  class MenuOptions < SitePrism::Section
    element :navigation_bar, '#navigation-bar'
    element :admin_dasboard, 'a[ui-sref="admin.dashboard"]'
    element :admin_setup, 'a[ui-sref="admin.setup"]'
    element :admin_e911, 'a´[ui-sref="admin.e911"]'
    element :admin_reports, 'a[ui-sref="admin.reporting-analytics"]'
    element :admin_announcements, 'a[ui-sref="admin.announcement-center"]'
    element :admin_account_billing, 'a[ui-sref="admin.account-billing-information"]'
    
  end

  class SetupMenu < SitePrism::Section
    element :users, 'a[ui-sref="admin.setup.user"]'
    element :departments, 'a[ui-sref="admin.setup.department"]'
    element :menu, 'a[ui-sref="admin.setup.menu"]'
    element :phone_number, 'a[ui-sref="admin.setup.phone-number"]'
  end

  class UserDetails < Siteprism::Section
      element :txt_first_name, 'input[placeholder="First Name"]'
      element :txt_last_name, 'input[placeholder="Last Name"]'
      element :txt_email, 'input[placeholder="E-mail"]'
      element :txt_password, 'input[placeholder="Password"]'
      element :txt_password_repeart, 'input[placeholder="Repeat"]'
      element :txt_extension, 'input[placeholder="Extension"]'
      element :txt_direct_number, 'div[class="control ng-binding"]:nth-of-type(2)'
      element :select_outbound_caller_id, 'select[data-ng-options$="outboundCallers"]
      
  end
end
