require_relative '../../../../sections/admin/setup/user/user'
require_relative '../../../../sections/admin/setup/setup'
require_relative '../../../../pages/main/home'
require_relative '../../../../pages/admin/dashboard/dashboard'
require_relative '../setup'

class User < Setup
  
  section :user_main, Sections::SetupMain, '.webapp-admin-page-main'
  section :details, Sections::UserDetails, '.page-details'
  section :tooltips, Sections::TollTips, '.popover.admin-tooltip'
  

 
  # section :tooltips, Sections::Tooltips, '.page-details'

  def access_user_menu
    menu.users.click
  end

  # validate each line of grid
  def is_user_in_grid(user)
    user_main.wait_until_grid_rows_visible
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
    user_main.wait_until_grid_rows_visible
    setup.grid_rows.each do |u|
      if u.text.include?(user[:extension]) && u.text.include?(user[:name]) && u.text.include?(user[:type]) && u.text.include?(user[:direct])
        u.click
      end
    end
    sleep(1)
  end

  def grid_check_user_info(user)
    user_main.wait_until_grid_rows_visible
    setup.grid_rows.each do |u|
      if u.text.include?(user[:extension]) && u.text.include?(user[:name]) && u.text.include?(user[:type]) && u.text.include?(user[:direct])
        true if u.include?(grid_icon_crm)
      end
    end
    sleep(1)
  end

  def is_checkbox_checked(element)
    checks = all('.checkbox')
    checks.each do |u|
      if u.text == element
        puts u.text
        return status = u.checked?
        puts status
      end
    end
  end

  def change_user_data(user)
    details.txt_first_name.set (user[:first_name])
    details.txt_last_name.set (user[:last_name])
    details.txt_email.set (user[:email])
    details.txt_extension.set (user[:extension])
    details.checkbox_voicemail.click
    details.checkbox_callback_request.click
    details.checkbox_require_key_press.click
    details.txt_number_rings. set(user[:number_of_rings])
    details.checkbox_inbound_call_recording.click
    details.checkbox_outbound_call_recording.click
    details.checkbox_call_pickup.click
  end

  def crm_feature_enable
    sleep(1)
    details.wait_until_btn_save_user_visible
    sleep(1)
    details.checkbox_crm.click
    details.btn_save_user.click
    sleep(2)
  end

  def crm_feature_disable
    details.wait_until_btn_save_user_visible
    sleep(1)
    details.checkbox_crm.click
    details.btn_save_user.click
    wait_until_grid_rows_visible
  end

  def user_allow_crm_feature(user)
    home = Home.new
    admin_dashboard = Dashboard.new

    home.goto_admin
    admin_dashboard.wait_until_btn_continue_visible
    admin_dashboard.btn_continue.click
    admin_dashboard.options.admin_setup.click
    # select user and allow CRM feature
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
      'http://api.marcel.dev.ringbyname.com/auth?',
      body: user.to_json,
      headers: headers
    )

    number_of_license = @response.parsed_response['data']['account']['crm']['licenses']

    number_of_license
  end
end
