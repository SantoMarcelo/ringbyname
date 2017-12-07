
require_relative '../pages/login'
require_relative '../pages/admin/dashboard'
require_relative '../pages/admin/setup/users'

describe('access admin page', :admin) do
  before(:each) do
    login_page.load
    login_page.do_login('devmarcelo.user1@ringbyname.com', '123456asd')
    home.wait_until_home_menu_visible
  end
  it('go to admin page') do |e|
    e.step('when I on home page') do
      expect(login_page.current_url).to end_with '/#!/app/welcome-page'
    end

    e.step('and I access the admin page') do
      home.goto_admin
    end

    e.step('I can see admin dashboard') do
      expect(admin_dashboard.current_url).to end_with '/#!/admin/dashboard'
      admin_dashboard.wait_until_btn_continue_visible
      admin_dashboard.btn_continue.click
    end
  end
  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
  end
end

describe('validate admin Setup', :setup) do
  before do
    login_page.load
    login_page.do_login('devmarcelo.user1@ringbyname.com', '123456asd')
    home.wait_until_home_menu_visible
    home.goto_admin
    admin_dashboard.wait_until_btn_continue_visible
    admin_dashboard.btn_continue.click
  end

  describe('validate users setup') do
    it('access user setup and validate user list') do |e|
      e.step('when I on admin page') do
        admin_dashboard.admin_setup.click
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

        expect(@user1[:extension]).to eql users.grid_line_one_ext.text
        expect(@user1[:name]).to eql users.grid_line_one_name.text
        expect(@user1[:type]).to eql users.grid_line_one_type.text
        expect(@user1[:direct]).to eql users.grid_line_one_direct.text

        expect(@user2[:extension]).to eql users.grid_line_two_ext.text
        expect(@user2[:name]).to eql users.grid_line_two_name.text
        expect(@user2[:type]).to eql users.grid_line_two_type.text
        expect(@user2[:direct]).to eql users.grid_line_two_direct.text

        expect(@user3[:extension]).to eql users.grid_line_tree_ext.text
        expect(@user3[:name]).to eql users.grid_line_tree_name.text
        expect(@user3[:type]).to eql users.grid_line_tree_type.text
        expect(@user3[:direct]).to eql users.grid_line_tree_direct.text

        expect(@user4[:extension]).to eql users.grid_line_four_ext.text
        expect(@user4[:name]).to eql users.grid_line_four_name.text
        expect(@user4[:type]).to eql users.grid_line_four_type.text
        expect(@user4[:direct]).to eql users.grid_line_four_direct.text

        expect(users.info_total_records.text).to eql '4'
        
      end
    end
    
    it('validate user details') do |e|
      e.step('when I on users setup') do
        admin_dashboard.admin_setup.click
      end
      e.step('and I select the first user') do
        find('article.ng-scope:nth-child(1)').click
      end
      e.step('then I check user informations') do
              
      end
    end
  end

  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
  end

end
