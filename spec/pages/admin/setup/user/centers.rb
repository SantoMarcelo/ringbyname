require_relative '../../../../sections/admin/setup/user/user'
require_relative '../../../../sections/admin/setup/setup'
require_relative '../../../../sections/admin/setup/user/centers'
require_relative '../../../../pages/main/home'
require_relative '../../../../pages/admin/dashboard/dashboard'
require_relative '../setup'

class Center < Setup

  section :setup, Sections::CenterSetup, '.page-main'
  section :details, Sections::CenterDetails, '.page-details'
  section :delete_modal, Sections::DeleteModal, '.modal-dialog'

  def check_is_center_in_grid(center)
    setup.grid_list_items.each do |item|
      if item.text.include?(center[:name]) &&
          item.text.include?(center[:city]) &&
          item.text.include?(center[:state]) &&
          item.text.include?(center[:country_uf]) &&
          item.text.include?(center[:time_zone])
        return true
      end
    end
    return false
  end

  def select_center(center)
    setup.wait_for_grid
    setup.grid_list_items.each do |item|
      puts item.text
      if item.text.include?(center[:name]) &&
          item.text.include?(center[:city]) &&
          item.text.include?(center[:state]) &&
          item.text.include?(center[:country_uf]) &&
          item.text.include?(center[:time_zone])
        item.click
      end
    end
  end
end