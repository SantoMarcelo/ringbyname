
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
    elements :grid_icon_crm, '.column-crm i'
  
    element :select_number_pages, '.control .select select'
    elements :select_number_page_options, '.control .select select option'
    element :info_total_records, 'strong[class="ng-binding"]'
    elements :btn_page_number, 'ul.pagination li' 
    # Settings for all users
    element :link_outbound_caller, 'a[ui-sref="admin.setup.setup.outbound"]'
    element :link_multiple_password, 'a[ui-sref="admin.setup.setup.password"]'

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