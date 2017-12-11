
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

        expect(users.is_user_in_grid(@user1)).to eql true
        expect(users.is_user_in_grid(@user2)).to eql true 
        expect(users.is_user_in_grid(@user3)).to eql true 
        expect(users.is_user_in_grid(@user4)).to eql true  
       
        expect(users.info_total_records.text).to eql '4'

      end
    end
  end
  # describe('validate users details', :user_details) do
  #   it('validate user information') do |e|
  #     e.step('when I on users setup') do
  #       admin_dashboard.options.admin_setup.click
  #     end
  #     e.step('and I select the first user') do
  #       find('article.ng-scope:nth-child(1)').click
  #     end
  #     e.step('then I check user informations') do

  #     end
  #   end
  # end

  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
    Capybara.current_session.driver.quit
  end
end
