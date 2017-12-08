
require_relative '../../pages/login'
require_relative '../../pages/admin/dashboard'
require_relative '../../pages/admin/setup/users'

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
