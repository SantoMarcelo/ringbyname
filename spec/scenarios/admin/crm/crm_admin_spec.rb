require_relative '../../../pages/login/login'
require_relative '../../../pages/admin/dashboard/dashboard'
require_relative '../../../pages/admin/setup/user/users'
require_relative '../../../pages/admin/crm/crm'

require_relative '../../../sections/admin/crm/crm'
# equire_relative '../../../pages/main/home'

describe('validate CRM admin') do
  describe('validate opportunities') do
    before(:each) do
      login_page.load
      login_page.do_login($admin_user)
      home.wait_until_home_menu_visible
      home.wait_until_user_status_visible
      puts 'go to admin'
      home.goto_admin
      puts 'foi pro admin'
      admin_dashboard.wait_until_btn_continue_visible
      admin_dashboard.btn_continue.click
      # create opportunities

      # end create
    end
    it('validate opportunitie search', :admin_crm_opportunities) do |e|
      puts 'validate opportunitie search'
    #   e.step('given I has opportunities to search') do
    #     puts 'given I has opportunities to search'
    #     crm_admin.insert_opportunity(9)
    #   end
      e.step('when I on admin page') do
        puts 'when I on admin page'
        admin_dashboard.options.admin_crm.click
      end
      e.step('I can see the user setup') do
        puts 'I can see the user setup'
        expect(crm_admin.admin_title.text).to eql 'CRM'
      end
      e.step('when I select opportunities menu') do
        puts 'when I select opportunities menu'
        crm_admin.menu.opportunities.click
      end
      e.step('then I can see the opportunities page') do
        puts 'then I can see the opportunities page'
        expect(crm_admin.oppo.title.text).to eql 'Opportunities'
      end
      e.step('when I search without any filter') do
        puts 'when I search without any filter'
        crm_admin.oppo.click_button('Search')
        
      end
      e.step('then I can see all opportunities')do
        puts 'then I can see all opportunities'
        crm_admin.oppo.wait_until_oppo_grid_rows_visible
        expect(crm_admin.oppo.oppo_grid_rows.length).to eql 9
      end
      e.step('when I filter search by follow-up date')do
        puts'when I filter search by follow-up date'
        follow_from = Date.today
        follow_to = Date.today +3
        # follow_from.strftime(%m-%m-%y)
        # follow_to.strftime(%f) 

        puts Date.today +3
        crm_admin.oppo.follow_update_from.set(follow_from)
        crm_admin.oppo.follow_update_to.set(follow_to)
        sleep 30
      end
      e.step('then I can see the filtred list')do
        puts 'then I can see the filtred list'  
      end

    end
    
  end
end
