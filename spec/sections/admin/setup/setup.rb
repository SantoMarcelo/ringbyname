
module Sections
  
class SetupMenu < SitePrism::Section
    element :users, 'a[ui-sref="admin.setup.user"]'
    element :departments, 'a[ui-sref="admin.setup.department"]'
    element :menu, 'a[ui-sref="admin.setup.menu"]'
    element :phone_number, 'a[ui-sref="admin.setup.phone-number"]'
  end

  class SetupMain < SitePrism::Section
    element :title, '.page-main .main-title'
    element :txt_search, '.form input.input'
    element :btn_search, '.form button.button'
    element :btn_clear_search, '.icon .delete'
    element :icon_search_tooltip, 'i.icon-tooltip:nth-child(3)'
       
    element :icon_grid_tooltip, 'i.icon-tooltip:nth-child(2)'
    elements :grid_rows, 'article.ng-scope'
    elements :grid_icon_admin, '.column-admin:last-child i'
    element :grid_icon_crm, '.column-crm > i[data-ng-if="user.crm.is_enabled"]'
  
    element :select_number_pages, 'select[class^="option.value"]'
    element :info_total_records, 'strong[class="ng-binding"]'
    # Settings for all users
    element :link_outbound_caller, 'a[ui-sref="admin.setup.user.outbound"]'
    element :link_multiple_password, 'a[ui-sref="admin.setup.user.password"]'

    def do_search(info)
      self.setup.txt_search.set (info)
      self.setup.btn_search.click
    end

  end



end