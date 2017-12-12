require_relative '../../../sections/admin/setup/user_admin'
require_relative '../../../sections/admin/setup/setup_menu'

class User < SitePrism::Page
  # search elements
  element :txt_search, '.input'
  element :btn_search, '.button'
  # all rows in user grid
  elements :grid_rows, 'article.ng-scope'

  element :select_number_pages, 'select[class^="option.value"]'
  element :info_total_records, 'strong[class="ng-binding"]'
  # Settings for all users
  element :link_outbound_caller, 'a[ui-sref="admin.setup.user.outbound"]'
  element :link_multiple_password, 'a[ui-sref="admin.setup.user.password"]'
  # tooltips
  element :tool_tip_search, 'i[tag="ADMIN_TOOLTIP_00069"]'
  element :tool_tip_users_extension, 'i[tag="ADMIN_TOOLTIP_00070"]'

  section :menu, Sections::SetupMenu, '.navigation-left'
  section :details, Sections::UserDetails, '.page-details'

  def access_user_menu
    menu.users.click
  end

  #validate each line of grid
  def is_user_in_grid(user)
   self.wait_until_grid_rows_visible
    grid_rows.each do |u|
      if u.text.include?(user[:extension]) && u.text.include?(user[:name]) && u.text.include?(user[:type]) && u.text.include?(user[:direct])
       return true
      end
    end
    return false
  end

  def select_user_in_grid(user)
    self.wait_until_grid_rows_visible
    grid_rows.each do |u|
      if u.text.include?(user[:extension]) && u.text.include?(user[:name]) && u.text.include?(user[:type]) && u.text.include?(user[:direct])
       u.click
      end
    end 
  end

  def validate_user_details(user)
    self.details.txt_first_name.text.include?(user[:firstName])
  end

end
