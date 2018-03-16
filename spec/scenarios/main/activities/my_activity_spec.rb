require_relative '../../../pages/login/login'
require_relative '../../../pages/main/home'
require_relative '../../../pages/main/activities/activity'

describe('Validate My Activity', :activity_call_back) do
  before do
    login_page.load
    login_page.do_login($admin_user)
    home.wait_until_home_menu_visible
    home.wait_until_user_status_visible
  end
  describe('My Activity filters') do
    it('validate my activity filters') do |e|
        puts 'validate my activity filters'
      e.step('when I on home page') do
        puts 'when I on home page'
        expect(page.text.include?('Call Presence'))
      end
      e.step('and select my activity') do
        puts ' and select my activity'
        activity.my_activity.menu_my_activity.click
      end
      e.step('and I select call back request filter')do
        puts ' and I select call back request filter'
        activity.my_activity.btn_filter.click
        activity.select_filter('Callback Request')
        activity.my_activity.btn_filter.click
      end
      e.step('then I can see only this activity')do
        puts 'then I can see only this activity'
        expect(activity.my_activity.current_filters.text).to eql 'Type: Callback Request'
        expect(activity.my_activity.activity_callback_icon.length).to eql 2
        expect(activity.my_activity.activity_list.length).to eql 2
      end
      e.step('when I remove the current filter')do
        puts 'when I remove the current filter'
        activity.my_activity.remove_current_filters.click
        sleep 2
      end
      e.step('then I can see all activity itens')do
        puts 'then I can see all activity itens'
        expect(activity.my_activity.current_filters.text).to eql 'All'
        expect(activity.my_activity.activity_list.length > 2)
      end
      e.step('when I have selected filters')do
        puts 'when I have selected filters'
        activity.my_activity.btn_filter.click
        activity.select_filter('Callback Request')
        activity.my_activity.btn_filter.click
        expect(activity.my_activity.current_filters.text).to eql 'Type: Callback Request'
        expect(activity.my_activity.activity_callback_icon.length).to eql 2
        expect(activity.my_activity.activity_list.length).to eql 2
      end
      e.step('and I clear all filters')do
        puts ' and I clear all filters'
        activity.my_activity.btn_filter.click
        activity.my_activity.my_clear_filters.click
        activity.my_activity.btn_filter.click
      end
      e.step('then I can see all activities')do
        puts 'then I can see all activities'
        expect(activity.my_activity.current_filters.text).to eql 'All'
        expect(activity.my_activity.activity_list.length > 2)
      end
      e.step('when I select the callback filter')do
        puts 'when I select the callback filter'
        activity.my_activity.btn_filter.click
        activity.select_filter('Callback Request')
        activity.my_activity.btn_filter.click
      end
      e.step('and change to team activity list')do
        puts ' and change to team activity list'
        activity.team_activity.menu_team_activity.click
      end
      e.step('then I can\'t see the applied filter in my activity')do
        puts 'then I can\'t see the applied filter in my activity'
        expect(activity.my_activity.current_filters.text).to eql 'All'
        expect(activity.my_activity.activity_list.length > 2)
      end
      e.step('when I returnet to my activity list')do
        puts 'when I returnet to my activity list'
        activity.my_activity.menu_my_activity.click
      end
      e.step('then I can see the last applied filter')do
        puts 'then I can see the last applied filter'
        expect(activity.my_activity.current_filters.text).to eql 'Type: Callback Request'
        expect(activity.my_activity.activity_callback_icon.length).to eql 2
        expect(activity.my_activity.activity_list.length).to eql 2
      end
    end
    after do
      activity.team_activity.btn_filter.click
      activity.team_activity.my_clear_filters.click
      activity.team_activity.btn_filter.click
      expect(activity.team_activity.current_filters.text).to eql 'All'
      expect(activity.team_activity.activity_list.length > 2)
      end
  end
end
