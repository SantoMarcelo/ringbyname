module Sections
  class CenterDetails < SitePrism::Section
    # user information



  end

  class CenterSetup < SitePrism::Section

    element :title, '.webapp-admin-page-main>div>div>h4.main-title'
    element :tooltip_title, '.webapp-admin-page-main>div>div>h4.main-title>i'
    element :input_search, ''
    element :btn_search, ''
    element :btn_add, ''
    element :centers_grid, ''
  end


  class Messages < SitePrism::Section

    element :modal, '#modalContentId'
    element :btn_ok, '.swal2-confirm'

  end




end