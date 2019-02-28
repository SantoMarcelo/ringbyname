require_relative '../../../../sections/admin/setup/user/user'
require_relative '../../../../sections/admin/setup/setup'
require_relative '../../../../pages/main/home'
require_relative '../../../../pages/admin/dashboard/dashboard'
require_relative '../setup'

class User < Setup
  
  section :user_main, Sections::SetupMain, '.webapp-admin-page-main'
  section :details, Sections::UserDetails, '.page-details'
  section :tooltips, Sections::TollTips, '.popover.admin-tooltip'
  section :device_modal, Sections::Messages, '.modal'
  section :device_config_modal, Sections::ModalDevicesConfig, '.modal'
  section :landline_modal, Sections::ModalLandLine, '.modal'
  section :reset_modal, Sections::Messages, '.modal'
  section :details_cId, Sections::MassiveCallerId, '.webapp-admin-page-details'
  section :details_pass, Sections::MassivePassword, '.webapp-admin-page-details'
  element :user_grid_line, '.cell.column-name'
 
  # section :tooltips, Sections::Tooltips, '.page-details'

  def access_user_menu
    menu.users.click
  end

  def wait_for_grid_line
    while has_user_grid_line? == false do
      puts "waiting for data.."
    end

  end

  def wait_for_grid
    while user_main.has_grid_rows? == false do
      puts "waiting grid.."
    end
  end

  def wait_for_user_details
    while details.has_txt_first_name? == false do
      puts "waiting data.."
    end
  end
  # validate each line of grid
  def is_user_in_grid(user)
    wait_for_grid
    setup.grid_rows.each do |u|
      if u.text.include?(user[:extension]) && u.text.include?(user[:name]) && u.text.include?(user[:type]) && u.text.include?(user[:direct])
        return true
      end
    end
    false
  end

  def validate_details_tooltips
    tolltip_texts = []
    details.icon_tooltips.each do |u|
      u.click
      tooltips.wait_until_tooltip_text_visible
      tolltip_texts.push(tooltips.tooltip_text.text)
      u.click
    end
    return tolltip_texts
  end

  def select_user_in_grid(user)
    wait_for_grid
    setup.grid_rows.each do |u|
      if u.text.include?(user[:extension]) && u.text.include?(user[:name]) && u.text.include?(user[:type]) && u.text.include?(user[:direct])
        u.click
      end
    end
    sleep(1)
    wait_for_user_details
  end

  def grid_check_user_info(user)
    wait_for_grid
    setup.grid_rows.each do |u|
      if u.text.include?(user[:extension]) && u.text.include?(user[:name]) && u.text.include?(user[:type]) && u.text.include?(user[:direct])
        true if u.include?(grid_icon_crm)
      end
    end
    false
    sleep(1)
  end

  def grid_check_admin_user_info(user)
    wait_for_grid
    puts user[:extension]
    puts user[:name]
    setup.grid_rows.each do |u|
      if u.text.include?(user[:extension]) && u.text.include?(user[:name]) && u.text.include?(user[:type]) && u.text.include?(user[:direct])
        true if u.include?(setup.grid_icon_admin)
      end
    end
    false
    sleep(1)
  end

  def crm_feature_enable
    wait_for_user_details
    details.wait_until_btn_save_user_visible
    details.checkboxes.each do |u|
      u.click if u.text.include?('Enable CRM for this setup')
    end
    details.btn_save_user.click
    sleep(2)
  end

  def crm_feature_disable
    wait_for_user_details
    details.wait_until_btn_save_user_visible
    sleep(1)
    details.checkboxes.each do |u|
      u.click if u.text.include?('Enable CRM for this setup')
    end
    details.btn_save_user.click
    setup.wait_until_grid_rows_visible
  end

  def select_massive_user(user)
    details_cId.users_list.each do |u|
      u.click if u.text.include?(user[:name])      
    end
  end

  def user_allow_crm_feature(user)
    home = Home.new
    admin_dashboard = Dashboard.new

    home.goto_admin
    admin_dashboard.wait_until_btn_continue_visible
    admin_dashboard.btn_continue.click
    admin_dashboard.options.admin_setup.click
    # select setup and allow CRM feature
    select_user_in_grid(user)
    crm_feature_enable
    sleep(5)
    wait_until_message_visible
  end

  def get_number_of_crm_licenses
    user = { 'data' => {
      'username' => 'devmarcelo.user1@ringbyname.com',
      'password' => '123456asd',
      'stay_sign_in' => 0,
      'timezone' => 'America/Sao_Paulo'
    } }
    headers = {
      'X-Application-Id' => 'webapp',
      'X-Version' => 'v2'
    }

    @response = HTTParty.post(
      "http://api.#{$environment}-php56.dev.ringbyname.com/auth?",
      body: user.to_json,
      headers: headers
    )

    number_of_license = @response.parsed_response['data']['account']['crm']['licenses']
    number_of_license
  end


end
