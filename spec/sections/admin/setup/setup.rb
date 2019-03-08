
module Sections
  
  class SetupMenu < SitePrism::Section
    element :users, 'a[ui-sref="admin.setup.user"]'
    element :departments, 'a[ui-sref="admin.setup.department"]'
    element :menu, 'a[ui-sref="admin.setup.menu"]'
    element :phone_number, 'a[ui-sref="admin.setup.phone-number"]'
  end

  class SetupMain < SitePrism::Section
    element :title, '.page-main .main-title.user-title'
    element :txt_search, '.user-form-search-input'
    element :btn_search, '.user-form-search-button'
    element :btn_clear_search, '.icon .delete'
    element :icon_search_tooltip, 'i.icon-tooltip:nth-child(3)'
       
    element :icon_grid_tooltip, 'i.icon-tooltip:nth-child(2)'
    elements :grid_rows, 'article.user-grid-list-item'
    elements :grid_icon_admin, '.column-admin .user-table-list-admin-icon'
    elements :grid_icon_crm, '.column-crm .user-table-list-crm-icon'
  
    element :select_number_pages, '.control #user-pagination-itens-page'
    elements :select_number_page_options, '.control .select select option'
    element :info_total_records, '#user-pagination-total-itens'
    elements :btn_page_number, 'dir-pagination-controls#user-pagination-pages-numbers ul li'
    # Settings for all users
    element :link_outbound_caller, 'a[ui-sref="admin.setup.user.outbound"]'
    element :link_multiple_password, 'a[ui-sref="admin.setup.user.password"]'

    def do_search(info)
      self.setup.txt_search.set (info)
      self.setup.btn_search.click
    end

    def change_page(page_number)
      self.btn_page_number.each do |u|
        u.text
        u.click if u.text.include?(page_number.to_s)
      end
     end
  end

  class CrmMenu < SitePrism::Section
    element :opportunities, 'a[ui-sref="admin.crm.opportunities"]'
    element :analytics, 'a[ui-sref="admin.crm.analytics"]'
    element :souces, 'a[ui-sref="admin.crm.sources"]'
  end

  class Departmets < SetupMain
    element :add_depto, '.add-department'
    element :hold_music_manager, 'a[href*="music-on-hold"]'
    
  end


end