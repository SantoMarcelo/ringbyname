require_relative '../../../../pages/login/login'
require_relative '../../../../pages/main/home'
require_relative '../../../../pages/main/features/crm/crm_mini_app'
require_relative '../../../../pages/login/reset_password'
require_relative '../../../../pages/main/contacts/contact'
require_relative '../../../../pages/admin/dashboard/dashboard'
#miniapp_crm_geral - :opportunity_general 
describe('CRM - Opportunity', :miniapp_crm_geral  ) do
  before do
    # if users.get_number_of_crm_licenses == 0
    #   provisioning('account','crm_licenses', '1')
    # end

    system("mysql -h mysql.#{$environment}-php56.dev.ringbyname.com -u devroot -ptesttest -f < sql/delete_opportunity.sql")
    Capybara.page.driver.browser.manage.window.maximize
    login_page.load
    login_page.do_login(get_admin())
    home.wait_until_home_features_visible
    home.wait_until_user_status_visible
    admin_user = get_admin()
    #set_user_data(admin_user)
    followup = Date.today
    close_date = followup+1
    @opportunity1 = {
      name: 'Test Opportunity 1',
      source: 'Social Media Site',
      status: 'Attempted',
      probability: '25%',
      product: 'Test Product 1',
      price: '$199.99',
      action: 'Phone Call',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: admin_user[:full_name]
    }
    @opportunity2 = {
      name: 'Test Opportunity 2',
      source: 'Website',
      status: 'Contacted',
      probability: '50%',
      product: 'Test Product 2',
      price: '$299.99',
      action: 'Email',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: admin_user[:full_name]
    }
    @opportunity3 = {
      name: 'Test Opportunity 3',
      source: 'Word of Mouth',
      status: 'Qualified',
      probability: '75%',
      product: 'Test Product 3',
      price: '$399.99',
      action: 'Prepare Quote',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: admin_user[:full_name]
    }
    @opportunity4 = {
      name: 'Test Opportunity 4',
      source: 'Referral',
      status: 'Unqualified',
      probability: '100%',
      product: 'Test Product 4',
      price: '$499.99',
      action: 'Follow-up on Quote',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: admin_user[:full_name]
    }
    @opportunity5 = {
      name: 'Test Opportunity 5',
      source: 'Trade Show',
      status: 'Dead',
      probability: '25%',
      product: 'Test Product 5',
      price: '$599.99',
      action: 'Negotiate',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: admin_user[:full_name]
    }
    @opportunity6 = {
      name: 'Test Opportunity 6',
      source: 'Advertisement',
      status: 'Quoted',
      probability: '25%',
      product: 'Test Product 6',
      price: '$699.99',
      action: 'Phone Call',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: admin_user[:full_name]
    }
    @opportunity7 = {
      name: 'Test Opportunity 7',
      source: 'Online Search',
      status: 'Negotiating',
      probability: '50%',
      product: 'Test Product 7',
      price: '$799.99',
      action: 'Email',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: admin_user[:full_name]
    }
    @opportunity8 = {
      name: 'Test Opportunity 8',
      source: 'Self Generated',
      status: 'Closed Won',
      probability: '75%',
      product: 'Test Product 8',
      price: '$899.99',
      action: 'Prepare Quote',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: admin_user[:full_name]
    }
    @opportunity9 = {
      name: 'Test Opportunity 9',
      source: 'Movie',
      status: 'Closed Lost',
      probability: '100%',
      product: 'Test Product 9',
      price: '$999.99',
      action: 'Follow-up on Quote',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: admin_user[:full_name]
    }
    @opportunity10 = {
      name: 'Test Opportunity 10',
      source: 'Social Media Site',
      status: 'Attempted',
      probability: '50%',
      product: 'Test Product 10',
      price: '$1,099.99',
      action: 'Follow-up on Quote',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: admin_user[:full_name]
    }
    @opportunity11 = {
      name: 'Test Opportunity 11',
      source: 'Website',
      status: 'Contacted',
      probability: '75%',
      product: 'Test Product 11',
      price: '$1,199.99',
      action: 'Negotiate',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: admin_user[:full_name]
    }
    @opportunity12 = {
      name: 'Test Opportunity 12',
      source: 'Word of Mouth',
      status: 'Qualified',
      probability: '100%',
      product: 'Test Product 12',
      price: '$1,299.99',
      action: 'Negotiate',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: admin_user[:full_name]
    }
    @opportunity13 = {
      name: 'Test Opportunity 13',
      source: 'Referral',
      status: 'Unqualified',
      probability: '25%',
      product: 'Test Product 13',
      price: '$1,399.99',
      action: 'Send Agreement',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: admin_user[:full_name]
    }
    @opportunity14 = {
      name: 'Test Opportunity 14',
      source: 'Trade Show',
      status: 'Dead',
      probability: '50%',
      product: 'Test Product 14',
      price: '$1,499.99',
      action: 'Close',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: admin_user[:full_name]
    }
    @opportunity15 = {
      name: 'Test Opportunity 15',
      source: 'Advertisement',
      status: 'Quoted',
      probability: '75%',
      product: 'Test Product 15',
      price: '$1,599.99',
      action: 'Phone Call',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: admin_user[:full_name]
    }
  end
  describe('search opportunit in mini app', :master) do
    before do
      admin_user = get_admin()
      crm_mini_app.insert_opportunity(admin_user, 9)
    end
    it('seacrch by opportunity name', :miniapp_serach_by_name) do |e|
      puts 'seacrch by opportunity name'
       e.step(' When I access mini app and search by name') do
         home.access_crm
         crm_mini_app.crm_container.wait_for_opportunity_list
         crm_mini_app.crm_container.txt_search.set(@opportunity1[:name])
         crm_mini_app.crm_container.btn_apply.click
         sleep(1)
       end
       e.step('then I can see only the searched opportunity') do
        '  then I can see only the searched opportunity'
         puts @opportunity1[:contact_owner]
         expect(crm_mini_app.validate_opportunity_list(@opportunity1)).to eql true
         sleep 10
       end
    end
    it('search opportunity by status', :miniapp_serach_by_status) do |e|
      puts 'search opportunity by status'
      e.step('when I search by Attempted status') do
        puts '  search by Attempted status'
        home.access_crm
        crm_mini_app.crm_container.select_filter.find('option', text: 'Attempted').select_option
        crm_mini_app.crm_container.btn_apply.click
        sleep(1)
      end
      e.step('then I can see only opportunity with Attempted status') do
        puts '  then I can see only opportunity with Attempted status'
        expect(crm_mini_app.validate_opportunity_list(@opportunity1)).to eql true
      end
      e.step('when I search by Contacted status') do
        puts '  search by Contacted status'
        home.access_crm
        crm_mini_app.crm_container.select_filter.find('option', text: 'Contacted').select_option
        crm_mini_app.crm_container.btn_apply.click
        sleep(1)
      end
      e.step('then I can see only opportunity with Contacted status') do
        puts '  then I can see only opportunity with Contacted status'
        
        expect(crm_mini_app.validate_opportunity_list(@opportunity2)).to eql true
      end
      e.step('when I search by Qualified status') do
        puts '  search by Qualified status'
        home.access_crm
        crm_mini_app.crm_container.select_filter.find('option', text: 'Qualified').select_option
        crm_mini_app.crm_container.btn_apply.click
        sleep(1)
      end
      e.step('then I can see only opportunity with Qualified status') do
        puts '  then I can see only opportunity with Qualified status'
        
        expect(crm_mini_app.validate_opportunity_list(@opportunity3)).to eql true
      end
      e.step('when I search by Unqualified status') do
        puts '  search by Unqualified status'
        home.access_crm
        crm_mini_app.crm_container.select_filter.find('option', text: 'Unqualified').select_option
        crm_mini_app.crm_container.btn_apply.click
        sleep(1)
      end
      e.step('then I can see only opportunity with Unqualified status') do
        puts '  then I can see only opportunity with Unqualified status'
        
        expect(crm_mini_app.validate_opportunity_list(@opportunity4)).to eql true
      end
      e.step('when I search by Dead status') do
        puts '  search by Dead status'
        home.access_crm
        crm_mini_app.crm_container.select_filter.find('option', text: 'Dead').select_option
        crm_mini_app.crm_container.btn_apply.click
        sleep(1)
      end
      e.step('then I can see only opportunity with Dead status') do
        puts '  then I can see only opportunity with Dead status'
        
        expect(crm_mini_app.validate_opportunity_list(@opportunity5)).to eql true
      end
      e.step('when I search by Quoted status') do
        puts '  search by Quoted status'
        home.access_crm
        crm_mini_app.crm_container.select_filter.find('option', text: 'Quoted').select_option
        crm_mini_app.crm_container.btn_apply.click
        sleep(1)
      end
      e.step('then I can see only opportunity with Quoted status') do
        puts '  then I can see only opportunity with Quoted status'
        
        expect(crm_mini_app.validate_opportunity_list(@opportunity6)).to eql true
      end
      e.step('when I search by Negotiating status') do
        puts '  search by Negotiating status'
        home.access_crm
        crm_mini_app.crm_container.select_filter.find('option', text: 'Negotiating').select_option
        crm_mini_app.crm_container.btn_apply.click
        sleep(1)
      end
      e.step('then I can see only opportunity with Negotiating status') do
        puts '  then I can see only opportunity with Negotiating status'
        
        expect(crm_mini_app.validate_opportunity_list(@opportunity7)).to eql true
      end
      e.step('when I search by Closed Won status') do
        puts '  search by Closed Won status'
        home.access_crm
        crm_mini_app.crm_container.select_filter.find('option', text: 'Closed Won').select_option
        crm_mini_app.crm_container.btn_apply.click
        sleep(1)
      end
      e.step('then I can see only opportunity with Closed Won status') do
        puts '  then I can see only opportunity with Closed Won status'
        
        expect(crm_mini_app.validate_opportunity_list(@opportunity8)).to eql true
      end
      e.step('when I search by Closed Lost status') do
        puts '  search by Closed Lost status'
        home.access_crm
        crm_mini_app.crm_container.select_filter.find('option', text: 'Closed Lost').select_option
        crm_mini_app.crm_container.btn_apply.click
        sleep(1)
      end
      e.step('then I can see only opportunity with Closed Lost status') do
        puts '  then I can see only opportunity with Closed Lost status'
        
        expect(crm_mini_app.validate_opportunity_list(@opportunity9)).to eql true
      end
      e.step('when I search by All Open status') do
        puts '  search by All Open status'
        home.access_crm
        crm_mini_app.crm_container.select_filter.find('option', text: 'All Open').select_option
        crm_mini_app.crm_container.btn_apply.click
        sleep(1)
      end
      e.step('then I can see only opportunity with All Open status') do
        puts '  then I can see only opportunity with All Open status'
        expect(crm_mini_app.validate_opportunity_list(@opportunity8)).to eql false
        expect(crm_mini_app.validate_opportunity_list(@opportunity9)).to eql false
      end
    end
    after() do
      system("mysql -h mysql.#{$environment}-php56.dev.ringbyname.com -u devroot -ptesttest -f < sql/delete_opportunity.sql")
      Capybara.reset_sessions!
     end
  end
  describe('opportunity pagination', :miniapp_crm_pagination) do
    before do
      admin_user = get_admin()
      crm_mini_app.insert_opportunity(admin_user, 15)
    end
    it('validate mini app pagination', :mini_app_pagination) do |e|
      e.step('and I access crm mini app') do
        puts '  and I access crm mini app'
        home.access_crm
      end
      e.step('when I change the opportunity page') do
        puts '  when I change the opportunity page'
        crm_mini_app.crm_container.wait_for_opportunity_list
        crm_mini_app.crm_container.wait_for_pagination
        sleep 1
        crm_mini_app.goto_page(2)
        sleep(2)
      end
      e.step('then I can see the second page of opportunity') do
        puts '  then I can see the second page of opportunity'
        crm_mini_app.crm_container.wait_for_opportunity_list
        expect(crm_mini_app.validate_opportunity_list(@opportunity13)).to eql true
        expect(crm_mini_app.validate_opportunity_list(@opportunity14)).to eql true
        expect(crm_mini_app.validate_opportunity_list(@opportunity15)).to eql true
      end
      e.step('when I return to the first page') do
        puts '  when I return to the first page'
        crm_mini_app.goto_page(1)
        sleep(2)
      end
      e.step('then I can see the first page of opportunity') do
        puts '  then I can see the first page of opportunity'
        crm_mini_app.crm_container.wait_for_opportunity_list
        expect(crm_mini_app.validate_opportunity_list(@opportunity1)).to eql true
        expect(crm_mini_app.validate_opportunity_list(@opportunity2)).to eql true
        expect(crm_mini_app.validate_opportunity_list(@opportunity3)).to eql true
        expect(crm_mini_app.validate_opportunity_list(@opportunity4)).to eql true
        expect(crm_mini_app.validate_opportunity_list(@opportunity5)).to eql true
        expect(crm_mini_app.validate_opportunity_list(@opportunity6)).to eql true
        expect(crm_mini_app.validate_opportunity_list(@opportunity7)).to eql true
        expect(crm_mini_app.validate_opportunity_list(@opportunity10)).to eql true
        expect(crm_mini_app.validate_opportunity_list(@opportunity11)).to eql true
        expect(crm_mini_app.validate_opportunity_list(@opportunity12)).to eql true
      end
    end
    after() do
      system("mysql -h mysql.#{$environment}-php56.dev.ringbyname.com -u devroot -ptesttest -f < sql/delete_opportunity.sql")
      Capybara.reset_sessions!
     end
  end
  describe('opportunity ordering', :miniapp_crm_sort) do
    before do
      admin_user = get_admin()
      crm_mini_app.insert_opportunity(admin_user, 10)
    end
    it('validate opportunity ordering') do |e|
      e.step('when I have a unordered opportunity list') do
        puts '  when I have a unordered opportunity list'
        home.access_crm
        expect(crm_mini_app.crm_container.title.text).to eql 'CRM'
        crm_mini_app.crm_container.wait_for_opportunity_list
      end
      e.step('and I sort by ascending opportunity name') do
        puts '  and I sort by asendingc opportunity name'
        crm_mini_app.crm_container.list_header_name.click
        crm_mini_app.crm_container.wait_for_sort_asc_indicator
        sleep 2
      end
      e.step('then I should see the list sorted in ascending order') do
        puts '  then I should see the list sorted in ascending order'
        expect(crm_mini_app.crm_container.has_css?('.caret.active.asc')).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity1, 0)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity10, 1)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity2, 2)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity3, 3)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity4, 4)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity5, 5)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity6, 6)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity7, 7)).to eql true
      end
      e.step('and I sort by descending opportunity name') do
        puts '  and I sort by descending opportunity name'
        crm_mini_app.crm_container.list_header_name.click
        crm_mini_app.crm_container.wait_for_sort_desc_indicator
        sleep 2
      end
      e.step('then I should see the list sorted in ascending order') do
        puts '  then I should see the list sorted in ascending order'
        expect(crm_mini_app.crm_container.has_css?('.caret.active.up.desc')).to eql true 
        expect(crm_mini_app.validate_list_ordenation(@opportunity7, 0)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity6, 1)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity5, 2)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity4, 3)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity3, 4)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity2, 5)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity10, 6)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity1, 7)).to eql true
      end
      e.step('when I sort by acensding follow-up date') do
        puts '  when I sort by acensding follow-up date'
        crm_mini_app.crm_container.list_header_followup.click
        crm_mini_app.crm_container.wait_for_sort_asc_indicator
        sleep 2
      end
      e.step('then I should see the list sorted by ascending follow-up date') do
        puts '  then I should see the list ordered by ascending follow-up date'
        expect(crm_mini_app.crm_container.has_css?('.caret.active.asc')).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity1, 0)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity2, 1)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity3, 2)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity4, 3)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity5, 4)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity6, 5)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity7, 6)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity10, 7)).to eql true
      end
      e.step('when I sort by descending follow-up date') do
        puts '  when I sort by descending follow-up date'
        crm_mini_app.crm_container.list_header_followup.click
        crm_mini_app.crm_container.wait_for_sort_desc_indicator
        sleep 2
      end
      e.step('then I should see the list sorted by descending follow-up date') do
        puts '  then I should see the list ordered by descending follow-up date'
        expect(crm_mini_app.crm_container.has_css?('.caret.active.up.desc')).to eql true 
        expect(crm_mini_app.validate_list_ordenation(@opportunity10, 0)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity7, 1)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity6, 2)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity5, 3)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity4, 4)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity3, 5)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity2, 6)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity1, 7)).to eql true
      end
      e.step('when I sort by ascending Close date') do
        puts '  when I sort by ascending Close date'
        crm_mini_app.crm_container.list_header_close_date.click
        crm_mini_app.crm_container.wait_for_sort_asc_indicator
        sleep 2
      end
      e.step('then I should see the list ordered by ascending close date') do
        puts '  then I should see the list ordered by ascending close date'
        expect(crm_mini_app.crm_container.has_css?('.caret.active.asc')).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity1, 0)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity2, 1)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity3, 2)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity4, 3)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity5, 4)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity6, 5)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity7, 6)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity10, 7)).to eql true
      
      end
      e.step('when I sort by descending Close date') do
        puts '  when I sort by descending Close date'
        crm_mini_app.crm_container.list_header_close_date.click
        crm_mini_app.crm_container.wait_for_sort_desc_indicator
        sleep 2
      end
      e.step('then I should see the list ordered by descending close date') do
        puts '  then I should see the list ordered by descending close date'
        expect(crm_mini_app.crm_container.has_css?('.caret.active.up.desc')).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity10, 0)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity7, 1)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity6, 2)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity5, 3)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity4, 4)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity3, 5)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity2, 6)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity1, 7)).to eql true
      end
      e.step('when I sort by ascending price/cost') do
        puts '  when I sort by ascending price/cost'
        crm_mini_app.crm_container.list_header_cost.click
        crm_mini_app.crm_container.wait_for_sort_asc_indicator
        sleep 2
      end  
      e.step('then I should see the list ordered by ascending price/cost') do
        puts '  then I should see the list ordered by ascending price/cost'
        expect(crm_mini_app.crm_container.has_css?('.caret.active.asc')).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity1, 0)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity2, 1)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity3, 2)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity4, 3)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity5, 4)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity6, 5)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity7, 6)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity10, 7)).to eql true
      end
      e.step('when I sort by descending price/cost') do
        puts '  when I sort by descending price/cost'
        crm_mini_app.crm_container.list_header_cost.click
        crm_mini_app.crm_container.wait_for_sort_desc_indicator
        sleep 2
      end
      e.step('then I should see the list ordered by descending price/cost') do
        puts '  then I should see the list ordered by descending price/cost'
        expect(crm_mini_app.validate_list_ordenation(@opportunity10, 0)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity7, 1)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity6, 2)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity5, 3)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity4, 4)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity3, 5)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity2, 6)).to eql true
        expect(crm_mini_app.validate_list_ordenation(@opportunity1, 7)).to eql true
      end
    end
    after do 
      system("mysql -h mysql.#{$environment}-php56.dev.ringbyname.com -u devroot -ptesttest -f < sql/delete_opportunity.sql")
      Capybara.reset_sessions!
    end
  end
  describe('add opportunity', :miniapp_add_contact_opo) do
    # it('access contact card and add a opportunity') do |e|
    #   puts 'access contact card and add a opportunity'
    #   e.step('Given when I has CRM license allowed') do
    #     puts 'Given when I has CRM license allowed'
    #     # access admin page
    #     home.goto_admin
    #     admin_dashboard.wait_until_btn_continue_visible
    #     admin_dashboard.btn_continue.click
    #     admin_dashboard.options.admin_setup.click
    #     # select user and allow CRM feature
    #     users.select_user_in_grid($user1)
    #     users.crm_feature_enable
    #     sleep(5)
    #     users.wait_until_message_visible
    #     # validate if was allowed correctly
    #     expect(users.message.modal.text).to eql 'User updated successfully.'
    #     users.message.btn_ok.click
    #     users.wait_until_grid_rows_visible
    #     expect(users.grid_rows.include?(users.grid_icon_crm))
    #     users.select_user_in_grid($user1)
    #     expect(users.details.checkbox_crm).to be_checked
    #     # return to home page
    #     admin_dashboard.goto_home
    #   end
    #   e.step('when I on home page and access contact card') do
    #     puts 'when I on home page and access contact card'
    #     expect(login_page.current_url).to end_with '/#!/app/welcome-page'
    #     home.wait_until_contact_visible
    #     sleep(2)
    #     home.select_contact(@contacts[0])
    #     contact.wait_until_contact_card_visible
    #     expect(contact.verify_contact(@contacts[0])) == true
    #   end
    #   e.step('and I select CRM menu and click to add') do
    #     puts 'and I select CRM menu and click to add'
    #     contact.access_crm
    #     # find('.crm-tab__add-button').click
    #   end
    #   e.step('then I filled opportunity information') do
    #     puts 'then I filled opportunity information'
    #     contact.fill_opportunity_data(@opportunity)
    #   end
    #   e.step('Then I see the inserted message') do
    #     puts 'Then I see the inserted message'
    #     expect(contact.message.text).to eql 'Opportunity inserted.'
    #   end
    #   e.step('and I check if the opportunity is in grid') do
    #     puts 'and I check if the opportunity is in grid'
    #     expect(contact.validate_contact_opportunity_list(@opportunity)).to eql true
    #   end
    #   e.step('and access CRM and verify opportunities') do
    #     puts 'and access CRM and verify opportunities'
    #     puts 'acessando crm'
    #     home.access_crm
    #     crm_mini_app.wait_until_opportunity_list_visible
    #     expect(home.current_url).to end_with '/#!/app/crm'
    #     expect(crm_mini_app.validate_opportunity_list(@opportunity)).to eql true
    #   end
    # end
    # it('verify validations when insert opportunity') do |e|
    #   e.step('given when I on contactr card page') do
    #     home.wait_until_contact_visible
    #     sleep(2)
    #     home.select_contact(@contacts[0])
    #     contact.wait_until_contact_card_visible
    #   end
    #   e.step('and I add a oportunity') do
    #     contact.access_crm
    #   end
    #   e.step('when I try to inser opportunity without name') do
    #    puts 'when I try to inser opportunity without name'
    #     contact.oppo_form.select_oppo_next_action.send_keys :tab
    #     contact.oppo_form.date_oppo_follow_up.send_keys :tab
    #     contact.oppo_form.date_close_date.send_keys :tab
    #     contact.oppo_form.txt_oppo_comment.send_keys :tab

    #     contact.oppo_form.btn_oppo_save.click
    #   end
    #   e.step('then I see a validation message') do
    #     expect(contact.message.text).to eql 'Please provide the opportunity name.'
    #   end
    #   e.step('when I try to inser opportunity without source') do
    #     puts 'when I try to inser opportunity without source'
    #     sleep(5)
    #     contact.oppo_form.txt_oppo_name.set 'Oportunity Validations'
       
    #     contact.oppo_form.select_oppo_next_action.send_keys :tab
    #     contact.oppo_form.date_oppo_follow_up.send_keys :tab
    #     contact.oppo_form.date_close_date.send_keys :tab
    #     contact.oppo_form.txt_oppo_comment.send_keys :tab
       
    #     contact.oppo_form.btn_oppo_save.click
    #   end
    #   e.step('then I see a validation message') do
    #     expect(contact.message.text).to eql 'Invalid opportunity source.'
    #   end
    #   e.step('when I try to inser opportunity without status') do
    #     puts 'when I try to inser opportunity without status'
    #     sleep(5)
    #     contact.oppo_form.select_oppo_source.find('option', text: 'Website').select_option
       
    #     contact.oppo_form.select_oppo_next_action.send_keys :tab
    #     contact.oppo_form.date_oppo_follow_up.send_keys :tab
    #     contact.oppo_form.date_close_date.send_keys :tab
    #     contact.oppo_form.txt_oppo_comment.send_keys :tab
       
    #     contact.oppo_form.btn_oppo_save.click
    #   end
    #   e.step('then I see a validation message') do
    #         expect(contact.message.text).to eql 'Please provide a valid status.'
    #   end
    #   e.step('when I try to inser opportunity without probability') do
    #     puts 'when I try to inser opportunity without probability'
    #     sleep(5)
    #     contact.oppo_form.select_oppo_status.find('option', text: 'Qualified').select_option
       
    #     contact.oppo_form.select_oppo_next_action.send_keys :tab
    #     contact.oppo_form.date_oppo_follow_up.send_keys :tab
    #     contact.oppo_form.date_close_date.send_keys :tab
    #     contact.oppo_form.txt_oppo_comment.send_keys :tab
       
    #     contact.oppo_form.btn_oppo_save.click
    #   end
    #   e.step('then I see a validation message') do
    #     expect(contact.message.text).to eql 'Please provide a valid probability.'
    #   end
    #   e.step('when I try to inser opportunity without next action') do
    #     puts 'when I try to inser opportunity without next action'
    #     sleep(5)
    #     contact.oppo_form.select_oppo_prob.find('option', text: '50%').select_option
       
    #     contact.oppo_form.select_oppo_next_action.send_keys :tab
    #     contact.oppo_form.date_oppo_follow_up.send_keys :tab
    #     contact.oppo_form.date_close_date.send_keys :tab
    #     contact.oppo_form.txt_oppo_comment.send_keys :tab
       
    #     contact.oppo_form.btn_oppo_save.click
    #   end
    #   e.step('then I see a validation message') do
    #     expect(contact.message.text).to eql 'Please provide a valid next action.'
    #   end
    # end
  end
  describe('opportunity details', :miniapp_oppo_details) do
    before do
      @admin_user = get_admin()
      crm_mini_app.insert_opportunity(@admin_user, 5)
    end
    it('validate opportunity details visualization') do |e|
      e.step('Given when I on home page and access CRM mini app') do
        puts '  Given when I on home page and access CRM mini app'
        home.access_crm
        crm_mini_app.crm_container.wait_for_opportunity_list_column
        expect(crm_mini_app.crm_container.title.text).to eql 'CRM'
      end
      e.step('and I select a oportunity to see your details') do
        puts '  and I select a oportunity to see your details'
        crm_mini_app.select_opportunity(@opportunity1)
        sleep 2
      end
      e.step('then I should see all informations about the opportunity')do
        puts '  then I should see all informations about the opportunity'
        crm_mini_app.oppo_details.wait_for_opportunity_name
        expect(crm_mini_app.oppo_details.contact).to have_content(@admin_user[:full_name])
        expect(crm_mini_app.oppo_details.title).to have_content(@opportunity1[:name]) 
        expect(crm_mini_app.oppo_details.opportunity_name.text).to eql(@opportunity1[:name]) 
        expect(crm_mini_app.oppo_details.opportunity_status.text).to eql(@opportunity1[:status]) 
        #expect(crm_mini_app.oppo_details.opportunity_close_date.text).to eql(@opportunity1[:close_date]) 
        expect(crm_mini_app.oppo_details.opportunity_source.text).to eql(@opportunity1[:source]) 
        expect(crm_mini_app.oppo_details.opportunity_probality.text).to eql(@opportunity1[:probability]) 
        expect(crm_mini_app.oppo_details.opportunity_product.text).to eql(@opportunity1[:product]) 
        expect(crm_mini_app.oppo_details.opportunity_price.text).to eql(@opportunity1[:price]) 
        expect(crm_mini_app.oppo_details.opportunity_action.text).to eql(@opportunity1[:action]) 
        #expect(crm_mini_app.oppo_details.opportunity_followup_date.text).to eql(@opportunity1[:follow_up]) 
        expect(crm_mini_app.oppo_details.opportunity_comments.text).to eql(@opportunity1[:comment]) 
       end
    end
    after() do
      system("mysql -h mysql.#{$environment}-php56.dev.ringbyname.com -u devroot -ptesttest -f < sql/delete_opportunity.sql")
      Capybara.reset_sessions!
    end
  end
  describe('edit opportunity', :miniapp_edit_oppo) do
    before do
      @admin_user = get_admin()
      crm_mini_app.insert_opportunity(@admin_user, 5)
      followup = Date.today
      close_date = followup+1
      @opportunity_edited = {
        name: 'Test Opportunity Edited',
        source: 'Advertisement',
        status: 'Negotiating',
        probability: '75%',
        product: 'Test Product Edited',
        price: '$111.11',
        action: 'Close',
        follow_up:  followup.strftime("%m-%d-%Y"),
        close_date: close_date.strftime("%m-%d-%Y"),
        comment: 'Edited',
         contact_owner: @admin_user[:full_name]
      } 
    end
    it('edit opportunity through CRM mini app', :edit_oppo_miniapp) do |e|
      puts 'edit opportunity by CRM mini app'
      e.step('Given when I on home page and access CRM mini app') do
        puts '  Given when I on home page and access CRM mini app'
        home.access_crm
        crm_mini_app.crm_container.wait_for_opportunity_list_column
        expect(crm_mini_app.crm_container.title.text).to eql 'CRM'
      end
      e.step('and I select a oportunity to edit') do
        puts '  and I select a oportunity to edit'
        crm_mini_app.select_opportunity(@opportunity1)
        sleep 1
        crm_mini_app.crm_container.edit_icon.click
      end
      e.step('when I edit an opportunity') do
        puts '  when I edit an opportunity'
        crm_mini_app.oppo_form.wait_for_txt_oppo_name
        expect(crm_mini_app.crm_container.title.text).to eql 'CRM'
        crm_mini_app.oppo_form.txt_oppo_name.set(@opportunity_edited[:name])
        crm_mini_app.oppo_form.select_oppo_source.find('option', text: (@opportunity_edited[:source])).select_option
        crm_mini_app.oppo_form.select_oppo_status.find('option', text: (@opportunity_edited[:status])).select_option
        crm_mini_app.oppo_form.select_oppo_prob.find('option', text: (@opportunity_edited[:probability])).select_option
        crm_mini_app.oppo_form.txt_oppo_product.set(@opportunity_edited[:product])
        crm_mini_app.oppo_form.txt_oppo_product.send_keys :tab
        crm_mini_app.oppo_form.txt_oppo_price.set(@opportunity_edited[:price])
        crm_mini_app.oppo_form.txt_oppo_price.send_keys :tab
        set_date(crm_mini_app.oppo_form.date_oppo_follow_up['class'].gsub(" ", "."), @opportunity_edited[:follow_up])
        crm_mini_app.oppo_form.select_oppo_prob.click
        set_date(crm_mini_app.oppo_form.date_close_date['class'].gsub(" ", "."), @opportunity_edited[:close_date] )
        crm_mini_app.oppo_form.select_oppo_next_action.find('option', text: (@opportunity_edited[:action])).select_option
        crm_mini_app.oppo_form.select_oppo_next_action.click
        crm_mini_app.oppo_form.select_oppo_next_action.send_keys :tab
        crm_mini_app.oppo_form.date_oppo_follow_up.send_keys :tab
        crm_mini_app.oppo_form.txt_oppo_comment.set(@opportunity_edited[:comment])
        crm_mini_app.oppo_form.txt_oppo_comment.send_keys :tab
        crm_mini_app.oppo_form.btn_oppo_save.click
      end
      e.step('then I check if was updated correctly ') do
        puts '  then I check if was updated correctly '
        home.wait_until_message_visible
        expect(home.message.text).to eql 'Opportunity updated.'
        home.wait_until_message_invisible
        sleep 1
        crm_mini_app.oppo_details.wait_for_opportunity_name
        expect(crm_mini_app.oppo_details.contact).to have_content(@admin_user[:full_name])
        expect(crm_mini_app.oppo_details.title).to have_content(@opportunity_edited[:name]) 
        expect(crm_mini_app.oppo_details.opportunity_name.text).to eql(@opportunity_edited[:name]) 
        expect(crm_mini_app.oppo_details.opportunity_status.text).to eql(@opportunity_edited[:status]) 
        expect(crm_mini_app.oppo_details.opportunity_close_date.text).to eql(@opportunity_edited[:close_date].gsub("-", "/")) 
        expect(crm_mini_app.oppo_details.opportunity_source.text).to eql(@opportunity_edited[:source]) 
        expect(crm_mini_app.oppo_details.opportunity_probality.text).to eql(@opportunity_edited[:probability]) 
        expect(crm_mini_app.oppo_details.opportunity_product.text).to eql(@opportunity_edited[:product]) 
        expect(crm_mini_app.oppo_details.opportunity_price.text).to eql(@opportunity_edited[:price]) 
        expect(crm_mini_app.oppo_details.opportunity_action.text).to eql(@opportunity_edited[:action]) 
        expect(crm_mini_app.oppo_details.opportunity_followup_date.text).to eql(@opportunity_edited[:follow_up].gsub("-", "/")) 
        expect(crm_mini_app.oppo_details.opportunity_comments.text).to eql(@opportunity_edited[:comment]) 
        
        home.access_crm
        crm_mini_app.validate_opportunity_list(@opportunity_edited)
      end
    end
    it('validations in opportunity edit through CRM mini app', :validations_edit_oppo) do |e|
      e.step('Given when I on home page and access CRM mini app') do
        puts '  Given when I on home page and access CRM mini app'
        home.access_crm
        crm_mini_app.crm_container.wait_for_opportunity_list_column
        expect(crm_mini_app.crm_container.title.text).to eql 'CRM'
      end
      e.step('and I select a oportunity to edit') do
        puts '  and I select a oportunity to edit'
        crm_mini_app.select_opportunity(@opportunity1)
        sleep 1
        crm_mini_app.crm_container.edit_icon.click

      end
      e.step('when I try to save with empty opportunity name') do
        puts '  when I try to save with empty opportunity name'
        crm_mini_app.oppo_form.wait_for_txt_oppo_name
        crm_mini_app.oppo_form.txt_oppo_name.set("")
        crm_mini_app.oppo_form.select_oppo_prob.send_keys :tab
        crm_mini_app.oppo_form.txt_oppo_product.send_keys :tab
        crm_mini_app.oppo_form.txt_oppo_price.send_keys :tab
        crm_mini_app.oppo_form.select_oppo_next_action.send_keys :tab
        crm_mini_app.oppo_form.date_oppo_follow_up.send_keys :tab
        crm_mini_app.oppo_form.txt_oppo_comment.send_keys :tab
        crm_mini_app.oppo_form.btn_oppo_save.click
      end
      e.step('then I should see the validation message') do
        puts '  then I should see the validation message'
        expect(home.message.text).to eql 'Please provide the opportunity name.'
      end
    end
    after() do
      system("mysql -h mysql.#{$environment}-php56.dev.ringbyname.com -u devroot -ptesttest -f < sql/delete_opportunity.sql")
      Capybara.reset_sessions!
    end
  end

  # pending('upload attachments', :upload_attachment) do
  #   # it('attache file when create a opportunity') do |e|
  #   #   e.step('attach file') do
  #   #     home.wait_until_contact_visible
  #   #     sleep(2)
  #   #     home.select_contact(@contacts[0])
  #   #     contact.wait_until_contact_card_visible
  #   #     contact.access_crm_list
  #   #     contact.select_opportunity(@opportunity1)
  #   #     # contact.edit_oppo_form.link_upload_attach.click
  #   #     # contact.find('.fileinput-button > .icon-fontello-upload').click

  #   #     puts 'attach file'
  #   #     page.attach_file('.fileinput-button > .icon-fontello-upload', 'C:\Projects\automated-tests\R-app\rapp\spec\test_attach.docx')
  #   #   end
  #   # end
  # end

  # pending('opportunity owner', :oppo_owner)do
  # end

  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
    Capybara.current_session.driver.quit
  end

end