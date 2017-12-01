
require_relative '../pages/login'
require_relative '../pages/admin/dashboard'

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
    it('access user setup') do |e|
      e.step('when I on admin page') do
        admin_dashboard.admin_setup.click
      end
      e.step('the I can see the user setup') do
        expect(find('.page-title').text).to eql 'Setup'
      end
    end
    it('validate user list') do |e|
      e.step('when I on user setup page') do
      end

      e.step('then I check user list') do
        users.grid_user_list
      end
    end
  end
end
