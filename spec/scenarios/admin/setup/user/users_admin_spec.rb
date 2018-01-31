
require_relative '../../../../pages/login/login'
require_relative '../../../../pages/admin/dashboard/dashboard'
require_relative '../../../../pages/admin/setup/user/users'

describe('validate Users Setup', :usersetup) do
  before(:each) do
    login_page.load
    login_page.do_login($admin_user)
    home.wait_until_home_menu_visible
    home.wait_until_user_status_visible
    home.goto_admin
    admin_dashboard.wait_until_btn_continue_visible
    admin_dashboard.btn_continue.click

    @user1 = {
      extension: '101',
      name: 'Dev Marcelo 1 User',
      first_name: 'Dev Marcelo 1',
      last_name: 'User',
      email: 'devmarcelo.user1@ringbyname.com',
      type: 'R! User',
      direct: '12392080525',
      outbound_caller_id: '12392080525 (New user 9314129)',
      voicemail_password: '1234',
      number_of_rings: '5'
    }
    @user2 = {
      extension: '102',
      name: 'Dev Marcelo 2 User',
      type: 'R! User',
      direct: 'None'
    }
    @user3 = {
      extension: '103',
      name: 'Dev Marcelo 3 User',
      type: 'R! Virtual User',
      direct: 'None'
    }
    @user4 = {
      extension: '104',
      name: 'Dev Marcelo 4 User',
      type: 'R! Virtual User',
      direct: 'None'
    }
    @user_changed = {
      extension: '101',
      name: 'Dev Marcelo 1 User',
      first_name: 'Dev Marcelo 1 CHANGED',
      last_name: 'User CHANGED',
      email: 'devmarcelo.user1.CHANGED@ringbyname.com',
      type: 'R! User',
      direct: '12392080525',
      outbound_caller_id: '12392080525 (New user 9314129)',
      voicemail_password: '1234',
      number_of_rings: '10'
    }
  end

  describe('validate users list', :user_list) do
    it('access user setup and validate user list') do |e|
      puts 'access user setup and validate user list'
      e.step('when I on admin page') do
        puts 'when I on admin page'
        admin_dashboard.options.admin_setup.click
      end
      e.step('I can see the user setup') do
        puts 'I can see the user setup'
        expect(users.admin_title.text).to eql 'Setup'
      end
      e.step('and I can access the user setings') do
        puts 'and I can access the user setings'
        users.access_user_menu
        expect(users.user_main.title.text).to eql 'Users'
      end
      e.step('then I check user list') do
        puts 'then I check user list'
        expect(users.is_user_in_grid(@user1)).to eql true
        expect(users.is_user_in_grid(@user2)).to eql true
        expect(users.is_user_in_grid(@user3)).to eql true
        expect(users.is_user_in_grid(@user4)).to eql true
        expect(users.user_main.info_total_records.text).to eql '4'
      end
    end
  end
  describe('search users', :search_user) do
    it('validate all search cases')do |e|
      puts 'validate all search cases'
      e.step('when I on users setup')do
        puts 'when I on users setup'
        admin_dashboard.options.admin_setup.click
        expect(users.admin_title.text).to eql 'Setup'
        users.access_user_menu
        expect(users.user_main.title.text).to eql 'Users'
      end
      e.step('and search by extension')do
        puts 'and search by extension'
        users.user_main.txt_search.set (@user1[:extension])
        users.user_main.btn_search.click
      end
      e.step('then i can see only the filtred user')do
        puts 'then i can see only the filtred user'
        expect(users.is_user_in_grid(@user1)).to eql true
        expect(users.user_main.info_total_records.text).to eql '1'
      end
      e.step('and search by name')do
        puts 'and search by name'
        users.user_main.txt_search.set (@user2[:name])
        users.user_main.btn_search.click
      end
      e.step('then i can see only the filtred user')do
        puts 'then i can see only the filtred user'
        #users.user_main.wait_until_grid_rows_visible
        sleep 1
        expect(users.is_user_in_grid(@user2)).to eql true
        expect(users.user_main.info_total_records.text).to eql '1'
      end
      e.step('and search by type')do
        puts 'and search by type'
        users.user_main.txt_search.set (@user3[:type])
        users.user_main.btn_search.click
      end
      e.step('then i can see only the filtred user')do
        puts 'then i can see only the filtred user'
        sleep 1
        expect(users.is_user_in_grid(@user3)).to eql true
        expect(users.user_main.info_total_records.text).to eql '2'
      end
      e.step('and search by Direct#')do
        puts 'and search by Direct#'
        users.user_main.txt_search.set (@user1[:direct])
        users.user_main.btn_search.click
      end
      e.step('then i can see only the filtred user')do
        puts 'then i can see only the filtred user'
        sleep 1
        expect(users.is_user_in_grid(@user1)).to eql true
        expect(users.user_main.info_total_records.text).to eql '1'
      end
      e.step('and search with special character')do
        puts 'and search with special character'
        users.user_main.txt_search.set ('!@#$%¨&*()')
        users.user_main.btn_search.click
      end
      e.step('then i can see only the filtred user')do
        puts 'then i can see only the filtred user'
        sleep 1
        expect(users.user_main.grid_rows.empty?).to eql true
        expect(users.user_main.info_total_records.text).to eql '0'
        end
      e.step('validate clear search field')do
        puts 'validate clear search field'
        users.user_main.txt_search.set ('Clear search field') 
        users.user_main.btn_clear_search.click
      end
      e.step('validate what field is cleared and grid was refreshd with all users')do
      puts 'validate what field is cleared and grid was refreshd with all users'
        expect(users.user_main.txt_search.text).to eql ''
        expect(users.is_user_in_grid(@user1)).to eql true
        expect(users.is_user_in_grid(@user2)).to eql true
        expect(users.is_user_in_grid(@user3)).to eql true
        expect(users.is_user_in_grid(@user4)).to eql true
        expect(users.user_main.info_total_records.text).to eql '4'
      end
      e.step('validate search tooltips text')do
        puts 'validate search tooltips text'
        users.user_main.icon_search_tooltip.click
        users.tooltips.wait_until_tooltip_text_visible
        expect(users.tooltips.tooltip_text.text).to eql 'Enter any Extension number, telephone number, or name to find it in your account.'
      end
      e.step('validate grid tooltip')do
        puts 'validate grid tooltip'
        users.user_main.icon_grid_tooltip.click
        users.tooltips.wait_until_tooltip_text_visible
        expect(users.tooltips.tooltip_text.text).to eql 'Click on Deactivate to remove a user from the system and reset all of its stored settings. Deactivating an extension will remove all stored settings, voicemails, and configurations.'
      end
    end
  end

describe('validate users details', :user_details) do
    it('validate user information') do |e|
      
      puts 'validate user information'
      e.step('when I on users setup') do
        puts 'when I on users setup'
        admin_dashboard.options.admin_setup.click
      end
      e.step('and I select the first user') do
        puts 'and I select the first user'
        users.select_user_in_grid(@user1)
      end
      e.step('then I check user\' informations') do
        puts 'then I check user\'s informations'
        expect(users.details.txt_first_name.text.include?(@user1[:first_name]))
        expect(users.details.txt_last_name.text.include?(@user1[:last_name]))
        expect(users.details.txt_email.text.include?(@user1[:email]))
        expect(users.details.txt_extension.text.include?(@user1[:extension]))
        expect(users.details.txt_direct_number.text.include?(@user1[:direct]))
        expect(users.details.select_outbound_caller_id.text.include?(@user1[:outbound_caller_id]))
        voicemail_active = expect(users.details.checkbox_voicemail).to be_checked
        if voicemail_active == true
          expect(users.details.txt_voicemail_password.text.include?(@user1[:voicemail_password]))
        end
        expect(users.details.radio_auto_greeting).to be_checked
        expect(users.details.radio_text_greeting).not_to be_checked
        expect(users.details.radio_file_greeting).not_to be_checked
        expect(users.details.checkbox_callback_request).to be_checked
        expect(users.details.checkbox_require_key_press).to be_checked
        expect(users.details.txt_number_rings.text.include?(@user1[:number_of_rings]))
        expect(users.details.checkbox_inbound_call_recording).not_to be_checked
        expect(users.details.checkbox_outbound_call_recording).not_to be_checked
        expect(users.details.checkbox_call_pickup).to be_checked
      end
      e.step('and I validate all tooltips texts') do
        puts 'and I validate all tooltips texts'
        #Add all tooltips text in array to validate with array returned in validation method.
        tooltips_texts_expect =[
          "Please enter an e-mail to be used as a login for this user. This must be a unique e-mail. This email will also be used to send notifications to the user, such as new voicemail and fax alerts.",
          "Please enter a password for this user. Passwords are alphanumeric and may contain letter and number combinations as well as special characters.",
          "Please re-enter your password to check for accuracy.",
          "You may enter any 3 to 5-digit extension number not currently in use in your account",
          "This is the direct telephone number that has been assigned to this user by the system administrator. If you would like to change the telephone number assigned, please navigate to the Phone Numbers section of the admin panel.",
          "You may select what outbound caller ID will be used by this user when placing a call. This number will be displayed to all telephone numbers dialed by this user. To assign the same Outbound Caller ID to more than one user, consider using the \"Set Outbound Caller ID for Mutlitiple Users\" tool.",
          "Click on this option if you wish to attach an additional VoIP telephone, or software based softphone to this user.",
          "Click on this checkbox to enable routing of calls to a specific device.",
          "Click on this option if you would like the system to simultaneously route calls to a landline or mobile phone. Expert Tip: Try forwarding calls to a colleague while you are away on vaction, simply enter their extension number instead of a landline or mobile phone number",
          "Click on this checkbox to enable or disable voicemail for this user\'s extensions",
          "Enter any 4-digit numeric password for voicemail box access",
          "Select this option if you would like the system to use an automated voicemail greeting.",
          "Select a language and enter the voicemail greeting you would like the system to read to your callers",
          "Use this option if you would like to use an MP3 ro WAV file as a voicemail greeting",
          "Click on this checkbox to grant this user Administrator access to the system and all configuration settings."
        ]
        users.details.wait_until_btn_save_user_visible
        expect(users.validate_details_tooltips).to eql tooltips_texts_expect
       end
    end
end

  describe('validate users update', :user_update) do
    it('update users and check changed data') do |e|
      e.step('when I on users setup') do
        puts 'when I on users setup'
        admin_dashboard.options.admin_setup.click
      end
      e.step('and I select the first user') do
        puts 'and I select the first user'
        users.select_user_in_grid(@user1)
      end
      e.step('and I change user informatios') do
        puts 'and I change user informatios'
        users.change_user_data(@user_changed)
      end
      e.step('then I check if all changes are displayed correctly') do
        puts 'then I check if all changes are displayed correctly'
        expect(users.details.txt_first_name.text.include?(@user_changed[:first_name]))
        expect(users.details.txt_last_name.text.include?(@user_changed[:last_name]))
        expect(users.details.txt_email.text.include?(@user_changed[:email]))
        expect(users.details.txt_extension.text.include?(@user_changed[:extension]))
        expect(users.details.txt_direct_number.text.include?(@user_changed[:direct]))
        expect(users.details.select_outbound_caller_id.text.include?(@user_changed[:outbound_caller_id]))
        voicemail_active = expect(users.details.checkbox_voicemail).to be_checked
        if voicemail_active == true
          expect(users.details.txt_voicemail_password.text.include?(@user_changed[:voicemail_password]))
        end
        expect(users.details.radio_auto_greeting).to be_checked
        expect(users.details.radio_text_greeting).not_to be_checked
        expect(users.details.radio_file_greeting).not_to be_checked
        expect(users.details.checkbox_callback_request).to be_checked
        expect(users.details.checkbox_require_key_press).to be_checked
        expect(users.details.txt_number_rings.text.include?(@user_changed[:number_of_rings]))
        expect(users.details.checkbox_inbound_call_recording).not_to be_checked
        expect(users.details.checkbox_outbound_call_recording).not_to be_checked
        expect(users.details.checkbox_call_pickup).to be_checked
      end
    end
  end

  describe('Validate CRM Feature', :crm_feature) do
    it('update users to enable CRM feature') do |e|
      e.step('when I on users setup') do
        admin_dashboard.options.admin_setup.click
      end
      e.step('and I select the first user') do
        users.select_user_in_grid($user1)
      end 
      e.step('then I allow CRM feature to user') do
        users.crm_feature_enable
        expect(users.message.modal.text).to eql 'User updated successfully.'
        users.message.btn_ok.click
      end
      e.step('and I check if the change was saved correctly') do
        users.wait_until_grid_rows_visible
        expect(users.grid_rows.include? (users.grid_icon_crm))
        users.select_user_in_grid($user1)
        expect(users.details.checkbox_crm).to be_checked
      end
    end
  
    it('check maximum number of license validation message') do |e|
      e.step('Given I has only 1 CRM license') do
        #expect(users.get_number_of_crm_licenses).to eql 1
      end
      e.step('when I on users setup') do
        admin_dashboard.options.admin_setup.click
      end
      e.step('and I allow CRM feature to users') do
        users.select_user_in_grid($user2)
        users.crm_feature_enable
      end
      e.step('then I see the validation message') do
        expect(users.message.modal.text).to eql "Sorry, but you've reached the maximum number of CRM licenses for your account. If you still want to enable the CRM feature for this user, please buy another license or disable CRM of another user before proceeding."
      end
    end
    
    it('update users to disable CRM feature') do |e|
      e.step('when I on users setup') do
       admin_dashboard.options.admin_setup.click
      end
      e.step('and I select the first user') do
        users.select_user_in_grid($user1)
      end
      e.step('then I unallow CRM feature to user') do
        users.crm_feature_disable
        expect(users.message.modal.text).to eql 'User updated successfully.'
        users.message.btn_ok.click
      end
      e.step('and I check if the change was saved correctly') do
        users.wait_until_grid_rows_visible
        expect(page).not_to have_selector('.column-crm > i[data-ng-if="user.crm.is_enabled"]')
        users.select_user_in_grid($user1)
        sleep(2)
        expect(users.details.checkbox_crm).not_to be_checked
      end
    end

   
  end

  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
    Capybara.current_session.driver.quit
  end
end




