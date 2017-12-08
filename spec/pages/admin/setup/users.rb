require_relative '../../../sections/admin/setup/users_sections'

class User < SitePrism::Page
  # search elements
  element :txt_search, '.input'
  element :btn_search, '.button'
  # grid elements line 1
  element :grid_user_list, '.flex-table'
  element :grid_line_one_ext, 'article.ng-scope:nth-child(1) .column-ext'
  element :grid_line_one_name, 'article.ng-scope:nth-child(1) .column-name'
  element :grid_line_one_type, 'article.ng-scope:nth-child(1) .column-type'
  element :grid_line_one_direct, 'article.ng-scope:nth-child(1) .column-direct'
  element :grid_line_one_admin, 'article.ng-scope:nth-child(1) .column-admin'
  # grid elements line 2
  element :grid_line_two_ext, 'article.ng-scope:nth-child(2) .column-ext'
  element :grid_line_two_name, 'article.ng-scope:nth-child(2) .column-name'
  element :grid_line_two_type, 'article.ng-scope:nth-child(2) .column-type'
  element :grid_line_two_direct, 'article.ng-scope:nth-child(2) .column-direct'
  element :grid_line_two_admin, 'article.ng-scope:nth-child(2) .column-admin'
  # grid elements line 3
  element :grid_line_tree_ext, 'article.ng-scope:nth-child(3) .column-ext'
  element :grid_line_tree_name, 'article.ng-scope:nth-child(3) .column-name'
  element :grid_line_tree_type, 'article.ng-scope:nth-child(3) .column-type'
  element :grid_line_tree_direct, 'article.ng-scope:nth-child(3) .column-direct'
  element :grid_line_tree_admin, 'article.ng-scope:nth-child(3) .column-admin'
  # grid elements line 4
  element :grid_line_four_ext, 'article.ng-scope:nth-child(4) .column-ext'
  element :grid_line_four_name, 'article.ng-scope:nth-child(4) .column-name'
  element :grid_line_four_type, 'article.ng-scope:nth-child(4) .column-type'
  element :grid_line_four_direct, 'article.ng-scope:nth-child(4) .column-direct'
  element :grid_line_four_admin, 'article.ng-scope:nth-child(4) .column-admin'

  element :select_number_pages, 'select[class^="option.value"]'
  element :info_total_records, 'strong[class="ng-binding"]'
  # Settings for all users
  element :link_outbound_caller, 'a[ui-sref="admin.setup.user.outbound"]'
  element :link_multiple_password, 'a[ui-sref="admin.setup.user.password"]'
  # tooltips
  element :tool_tip_search, 'i[tag="ADMIN_TOOLTIP_00069"]'
  element :tool_tip_users_extension, 'i[tag="ADMIN_TOOLTIP_00070"]'

  section :menu, Sections::SetupMenu, '.navigation-left' 

  def access_user_menu
    self.menu.users.click
  end

end
