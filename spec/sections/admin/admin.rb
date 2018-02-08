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

      class TollTips < SitePrism::Section
        element :tooltip_text, '.popover .popover-content'
      end

      class MainMenu <SitePrism::Section
        element :menu, '.profile-media-content'
        element :receives_call_at, 'a[ui-sref="app.receive-calls-at"]'
        element :my_caller_id, 'a[ui-sref="app.my-outgoing-caller-id"]'
        element :my_profile, 'a[ui-sref="app.profile"]'
        element :languages, 'a[ui-sref="app.language-settings"]'
        element :home_page, 'a[ui-sref="app.welcome-page"]'
        element :logout, 'a[ui-sref="auth.logout"]'
      end
    
    end