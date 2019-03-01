module Sections
  class CenterDetails < SitePrism::Section
    # setup information



  end

  class CenterSetup < SitePrism::Section

    element :title, '.center-title'
    element :tooltip_title, '.webapp-admin-page-main>div>div>h4.main-title>i'
    element :input_search, '.center-form-search-input'
    element :btn_search, '.center-form-search-button'
    element :btn_add, '.add-center-button'
    element :grid_list, '.center-grid-list'
    elements :grid_list_items, '.center-grid-list-item'
    element :item_per_page, '#center-pagination-itens-page'
    element :total_records_found, '#center-pagination-total-itens'
    elements :pages_list, 'dir-pagination-controls[pagination-id="PaginationCallCenterID"]'

    def wait_for_grid
      while has_grid_list? == false do
        puts "waiting for grid.."
      end
    end

    def has_grid_items
      if(grid_list_items.length > 0)
        return true
      end
      return false
    end


  end

  class CenterDetails < SitePrism::Section
    element :title, '.center-details-title'
    element :name, '.center-details-input-name'
    element :city, '.center-details-input-city'
    element :state, '.center-details-input-state'
    element :select_country, '#center-details-select-country'
    element :select_time_zone, '#center-details-select-timezone'
    element :btn_save, '.center-details-btn-save'
    element :btn_remove, '.center-details-btn-remove'

    def wait_for_details
      while has_name? == false do
        puts 'waiting for details..'
      end
    end
  end

  class DeleteModal <SitePrism::Section
    element :title, '.modal-header .modal-title'
    element :message_text, '.modal-body p'
    element :btn_cancel, '.modal-footer .button-cancel'
    element :btn_confirm, '.modal-footer .button-save'

    def wait_for_modal
      while has_title? ==false do
        puts 'waiting for delete modal..'
      end
    end
  end

  class Messages < SitePrism::Section

    element :modal, '#modalContentId'
    element :btn_ok, '.swal2-confirm'

  end
end