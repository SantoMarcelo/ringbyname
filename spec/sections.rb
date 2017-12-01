
module Sections

    class Menu < SitePrism::Section

        element :navigation_bar, '#navigation-bar'
        element :admin_dasboard, 'a[ui-sref="admin.dashboard"]'
        alement :admin_setup, 'a[ui-sref="admin.setup"]'
        element :admin_e911, 'a´[ui-sref="admin.e911"]'
        element :admin_reports, 'a[ui-sref="admin.reporting-analytics"]'
        element :admin_announcements, 'a[ui-sref="admin.announcement-center"]'
        element :admin_account_billing, 'a[ui-sref="admin.account-billing-information"]'
        element :admin_support


    end

end


