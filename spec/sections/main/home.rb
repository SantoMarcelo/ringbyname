module Sections

class Contact < SitePrism::Section
  element :title, '.contacts-header-title'
  element :icon_add_contact, '.rbn-icon-common-contact-add'
  element :txt_search_contacts, '.input-search input'
  element :btn_group_filters, '.group-list-filters button'
  elements :group_filter_list, '.rbn-dropdown-content ul .checkbox .input-label'
  #elements :group_filter_checkbox_list, '.rbn-dropdown-content ul .checkbox .input-label'
  element :btn_clear_filters, '.rbn-dropdown-content span[data-ng-click="clearFilterGroup($event)"]'
  elements :selected_current_filters, '.group-list-filters-selected li'
  elements :remove_current_filters, '.group-list-filters-selected li .glyphicon-remove'
  elements :contact_list, '#contact-list .group-list li .opened li.list.ng-scope'
end


class HomeMenu < SitePrism::Section
    element :menu, '.profile-media-content'
    element :receives_call_at, 'a[data-ui-sref="app.receive-calls-at"]'
    element :my_caller_id, 'a[data-ui-sref="app.my-outgoing-caller-id"]'
    element :my_profile, 'a[data-ui-sref="app.profile"]'
    element :goto_admin, 'a[data-ui-sref="admin.dashboard"]'
    element :languages, 'a[data-ui-sref="app.language-settings"]'
    element :home_page, 'a[data-ui-sref="app.welcome-page"]'
    element :logout, 'a[data-ui-sref="auth.logout"]'
end

 
end
