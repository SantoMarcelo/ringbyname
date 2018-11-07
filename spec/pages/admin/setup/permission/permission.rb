require_relative '../setup'
require_relative '../../../../sections/admin/setup/permission/permission'

class Permission < Setup

  section :menu, Sections::SetupMenu, '.navigation-left'
  section :message, Sections::Messages, '.swal2-container'
  section :permission_details, Sections::PermissionSettings, '.page-details'
  section :setup_permission, Sections::PermissionMain, '.page-main .permission-area'
  section :setup_department_manager, Sections::SetupMain, '.page-main div[data-ng-include*="dep-managers-table"]'
  section :modal, Sections::PermissionModal, '.swal2-modal'

  def is_permission_group_in_grid(permission_group)
    setup_permission.wait_until_grid_rows_visible
    setup_permission.grid_rows.each do |u|
       true if u.text.include?(permission_group[:name])
    end
    false
  end

  def select_option(list, option)
    list.each do |item|
      if item.text.include?(option)
        item.click
      end
    end
  end

  def clear_permissions(permission)
    permission.each do |item|
      puts item
    end
  end

end