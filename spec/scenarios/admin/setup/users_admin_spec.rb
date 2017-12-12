
require_relative '../../../pages/login'
require_relative '../../../pages/admin/dashboard'
require_relative '../../../pages/admin/setup/users'

describe('validate Users Setup', :usersetup) do
  before do
    login_page.load
    login_page.do_login('devmarcelo.user1@ringbyname.com', '123456asd')
    home.wait_until_home_menu_visible
    home.wait_until_user_status_visible
    home.goto_admin
    admin_dashboard.wait_until_btn_continue_visible
    admin_dashboard.btn_continue.click

    @user1 = {
      extension: '101',
      name: 'Dev Marcelo 1 User',
      type: 'R! User',
      direct: '12392080525'
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
        @user = {
          first_name: 'Dev Marcelo 1',
          last_name: 'User',
          email: 'devmarcelo.user1@ringbyname.com',
          extension: '101',
          direct_number: '12392080525',
          outbound_caller_id: '12392080525 (New user 9314129)',
          voicemail_password: '1234'
        }
        expect(users.details.txt_first_name.text.include?(@user[:first_name]))
        expect(users.details.txt_last_name.text.include?(@user[:last_name]))
        expect(users.details.txt_email.text.include?(@user[:email]))
        expect(users.details.txt_extension.text.include?(@user[:extension]))
        expect(users.details.txt_direct_number.text.include?(@user[:direct_number]))
        expect(users.details.select_outbound_caller_id.text.include?(@user[:outbound_caller_id]))
       
        expect(users.details.txt_voicemail_password.texte.include?(@user[:voicemail_password]))
      end
    end
  end

  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
    Capybara.current_session.driver.quit
  end
end
