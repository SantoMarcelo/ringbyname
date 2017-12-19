
require_relative '../../../pages/login'
require_relative '../../../pages/admin/dashboard'
require_relative '../../../pages/admin/setup/users'

describe('validate Users Setup', :usersetup) do
  before(:each) do
    server = Couch::Server.new("http://couchdb.dev.ringbyname.com", "5984" )
    res = server.get("/account%2Fb1%2F09%2Fd4ae6352974e71f26a04054720d1/b109d4ae6352974e71f26a04054720d1")
    json = res.body
    puts json
    login_page.load
    login_page.do_login($marcel_user)
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
      direct: '12392065017'
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
      number_of_rings: '5'
    }
  end

  describe('validate users list', :userList) do
    it('access user setup and validate user list') do |e|
      e.step('when I on admin page') do
        admin_dashboard.options.admin_setup.click
      end
      e.step('I can see the user setup') do
        expect(find('.page-title').text).to eql 'Setup'
      end
      e.step('and I can access the user setings') do
        users.access_user_menu
      end
      e.step('then I check user list') do
        expect(users.is_user_in_grid(@user1)).to eql true
        expect(users.is_user_in_grid(@user2)).to eql true
        expect(users.is_user_in_grid(@user3)).to eql true
        expect(users.is_user_in_grid(@user4)).to eql true

        expect(users.info_total_records.text).to eql '4'
      end
    end
  end

  describe('validate users details', :user_details) do
    it('validate user information') do |e|
      e.step('when I on users setup') do
        admin_dashboard.options.admin_setup.click
      end
      e.step('and I select the first user') do
        users.select_user_in_grid(@user1)
      end
      e.step('then I check user informations') do
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
      e.step('then I validate all tooltips texts') do
        # need to create this validation
        # expect(users.validate_user_details_tooltips).to eql true
      end
    end
  end

  describe('validate users update', :user_update) do
    it('update users and check changed data') do |e|
      e.step('when I on users setup') do
        admin_dashboard.options.admin_setup.click
      end
      e.step('and I select the first user') do
        users.select_user_in_grid(@user1)
      end
      e.step('and I change user informatios') do
        users.change_user_data(@user_changed)
      end
      e.step('then I check if all changes are displayed correctly') do
      end
    end
  end

  describe('Validate CRM Feature', :crm_feature) do
    # it('update users to enable CRM feature') do |e|
    #   e.step('when I on users setup') do
    #     admin_dashboard.options.admin_setup.click
    #   end
    #   e.step('and I select the first user') do
    #     users.select_user_in_grid($marcel_user1)
    #   end
    #   e.step('then I allow CRM feature to user') do
    #     users.crm_feature_enable
    #     expect(users.message.modal.text).to eql 'User updated successfully.'
    #     users.message.btn_ok.click
    #   end
    #   e.step('and I check if the change was saved correctly') do
    #     users.wait_until_grid_rows_visible
    #     users.select_user_in_grid($marcel_user1)
    #     sleep(2)
    #     expect(users.details.checkbox_crm).to be_checked
    #   end
    # end

    # it('update users to disable CRM feature') do |e|
    #   e.step('when I on users setup') do
    #    admin_dashboard.options.admin_setup.click
    #   end
    #   e.step('and I select the first user') do
    #     users.select_user_in_grid($marcel_user1)
    #   end
    #   e.step('then I allow CRM feature to user') do
    #     users.crm_feature_disable
    #     expect(users.message.modal.text).to eql 'User updated successfully.'
    #     users.message.btn_ok.click
    #   end
    #   e.step('and I check if the change was saved correctly') do
    #     users.wait_until_grid_rows_visible
    #     users.select_user_in_grid($marcel_user1)
    #     sleep(2)
    #     expect(users.details.checkbox_crm).not_to be_checked
    #   end
    # end

    it('validate validation message') do |e|
      e.step('Given I has only 1 CRM license') do
        puts "###"
        puts $marcel_user.to_json
        
        puts "@@@@"
        puts @response
        puts "@@@@"
        if @response.success?
       @response.each do |u|
          puts "#####"
          puts u
          puts "****"
        end
      end
       end
      #  e.step('when I on users setup') do
      #   admin_dashboard.options.admin_setup.click
      #  end
      #  e.step('and I select the first user') do
      #    users.select_user_in_grid($marcel_user1)
      #  end
      #  e.step('and I try to allow CRM feature to user') do
      #    users.crm_feature_enable
      #  end
      #  e.step('then I see the validation message') do
      #   expect(users.message.modal.text).to eql 'You do not have sufficient CRM licenses.'
      #  end
    end
  end

  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
    Capybara.current_session.driver.quit
  end
end
