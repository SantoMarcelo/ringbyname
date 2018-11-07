
module Sections

  class Overview < SitePrism::Section
    #carroussel elements
    element :link_main, '.gallery a[ui-sref="admin.setup"]'
    element :link_e911, '.gallery a[ui-sref="admin.e911"]'
    element :link_reporting, '.gallery a[ui-sref="admin.reporting-analytics"]'
    element :link_annoucement, '.gallery a[ui-sref="admin.announcement-center"]'
    element :link_account_billing, '.gallery a[ui-sref="admin.account-billing-information"]'
    element :link_account_billing, '.gallery a[href^="http://support"]'

    element :btn_next, '.gallery button[class~="next"]'
    element :btn_next, '.gallery button[class~="previous"]'
  end

  class Annoucement < SitePrism::Section

  end

  class MoreQuickLinks < SitePrism::Section
    
  end
end
