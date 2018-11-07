module Sections
    class Activity < SitePrism::Section
      element :menu_my_activity, 'a[data-target="#my-activity"]'
      element :menu_team_activity, 'a[data-target="#team-activity"]'
      element :btn_filter, '.rbn-dropdown button.btn.btn-default'
      element :current_filters, '.activities .group-list-filters-selected'
      element :remove_current_filters, '.activities .group-list-filters-selected .glyphicon-remove'
      element :my_clear_filters, 'span[data-ng-click="clearFilterType($event)"]'
      element :team_clear_filters, 'span[data-ng-click="clearFilter($event, \'type\')"]'
      elements :activity_list, 'li.list.extension-list-note-activity-note-details'
      elements :activity_callback_icon, '.rbn-icon-activity-callback_insert'
      elements :filters_options, '.activities .rbn-dropdown-content .list-unstyled > li .radio'
    end

end
