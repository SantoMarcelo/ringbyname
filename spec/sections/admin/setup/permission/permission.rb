require_relative '../setup'

module Sections

  class PermissionMain < SitePrism::Section
    element :title, '.main-title'
    element :txt_search, '.form input.input'
    element :btn_search, '.form button.button'
    element :btn_clear_search, '.icon .delete'
    element :icon_search_tooltip, 'i.icon-tooltip:nth-child(3)'
       
    element :icon_grid_tooltip, 'i.icon-tooltip:nth-child(2)'
    elements :grid_rows, 'article.ng-scope'
    elements :grid_icon_admin, '.column-admin:last-child i'
    elements :grid_icon_crm, '.column-crm i'
  
    element :select_number_pages, '.control .select select'
    elements :select_number_page_options, '.control .select select option'
    element :info_total_records, 'strong[class="ng-binding"]'
    elements :btn_page_number, 'ul.pagination li'    
    element :permission_grid_header_name, '.permission-table header div.column-name'
    element :permission_grid_header_number, '.permission-table header div.column-number'
    element :add_new, 'a.add-permission'

  end

  class PermissionSettings < SitePrism::Section
    element :title, '.details-title'
    element :txt_group_name, '.section-details input.input'
    elements :permissions_list, '.permissions-rules-section .checkbox'
    elements :users_list, '.permissions-users-section .checkbox'
    element :btn_save, '.button'
  end

  class DepartmentManagers < SitePrism::Section

  end

  class PermissionModal < SitePrism::Section
    element :modal_text, '.swal2-content'
    element :modal_btn, '.swal2-confirm'
  end

end