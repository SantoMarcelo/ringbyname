module Sections
    class MenuOptions < SitePrism::Section
        element :navigation_bar, '#navigation-bar'
        element :admin_dasboard, 'a[ui-sref="admin.dashboard"]'
        element :admin_setup, 'a[ui-sref="admin.setup"]'
        element :admin_e911, 'a´[ui-sref="admin.e911"]'
        element :admin_crm, 'a[ui-sref="admin.crm"]'
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
      element :goto_admin, 'a[ui-sref="admin.dashboard"]'
      element :languages, 'a[ui-sref="app.language-settings"]'
      element :home_page, 'a[ui-sref="app.welcome-page"]'
      element :logout, 'a[ui-sref="auth.logout"]'
    end

    class SelectUser < SitePrism::Section
      element :input_search_user, '.users-directive-input-search'
      element :btn_clear_search, '.users-directive-btn-clear-search a'
      element :btn_search, '.users-directive-btn-search'
      element :check_select_all, '.users-directive-checkbox-select-all'
      elements :check_select_list, '.cell.column-select'
      elements :user_name_list, '.users-directive-grid-column-user-name-item'
      elements :center_name_list, '.users-directive-grid-column-center-name-item'
      element :item_per_page, '#users-directive-pagination-select-items-per-page'
      element :total_records_found, '#users-directive-pagination-total-items-returned'
      elements :page_number, '#users-directive-pagination-page-number'


      def wait_for_users
        while has_user_name_list? == false
          puts 'waiting for user list..'
        end
      end
    end

    end