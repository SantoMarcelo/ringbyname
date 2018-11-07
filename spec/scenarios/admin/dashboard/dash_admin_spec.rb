
require_relative '../../../pages/login/login'
require_relative '../../../pages/admin/dashboard/dashboard'
require_relative '../../../pages/admin/setup/user/users'

describe('access admin page', :admin) do
  before(:each) do
    login_page.load
    login_page.do_login(get_admin())
    home.wait_until_home_features_visible
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
