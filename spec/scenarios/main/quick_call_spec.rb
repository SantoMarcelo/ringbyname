require_relative '../../pages/login/login'
require_relative '../../pages/main/home'
require_relative '../../pages/main/features/quick_call/quick_call'
require_relative '../../sections/main/features/quick_call'

describe('validate quick call feature', :home_quick_call_feature) do
  before do
    login_page.load
    login_page.do_login($admin_user)
    home.wait_until_home_menu_visible
    home.wait_until_user_status_visible
  end
  describe('validate recent call list') do
    it('validate recent calls') do |e|
      e.step('when I on home page') do
        expect(page.text.include?('Call Presence'))
      end
      e.step('and I access a quick call menu') do
        quick_call.home_menu.quick_call.click
        sleep 5
      end
      e.step('and I check the recent call list') do
      end
    end
  end
end
